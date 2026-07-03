# Task 01 - GTM Event Schema

This document details the complete Google Tag Manager (GTM) event tracking schema and funnel drop-off tracking implementation for OrthoNow's digital platforms.

---

## 1. Complete Event Schema Matrix

| Event Name | Trigger Type | Key Parameters (Min 3) | Target GA4 Report / Custom Audience |
| :--- | :--- | :--- | :--- |
| `booking_step_complete` | Custom Event | 1. `step_number` (Integer)<br>2. `step_name` (String)<br>3. `clinic_location` (String)<br>4. `specialty` (String) | **Report:** Life Cycle > Engagement > Events<br>**Funnel:** Funnel Exploration (drop-off visualization)<br>**Audience:** "Booking Drop-offs" (Step 1 or 2 complete, but not 3) |
| `click_to_call` | Click - Just Links | 1. `click_text` (String)<br>2. `page_path` (String)<br>3. `click_url` (String) | **Report:** Engagement > Events (Conversions)<br>**Audience:** "High-Intent Hot Leads" (Users who initiated phone call) |
| `whatsapp_chat_click` | Click - Just Links | 1. `click_text` (String)<br>2. `page_path` (String)<br>3. `chat_placement` (String) | **Report:** Engagement > Events<br>**Audience:** "WhatsApp Inquirers" (Remarketing pool) |
| `patient_guide_download` | Custom Event | 1. `guide_name` (String)<br>2. `form_id` (String)<br>3. `page_path` (String) | **Report:** Engagement > Events (Conversions)<br>**Audience:** "Lead - Guide Downloaders" (Information gatherers, nurture via CRM) |
| `view_location_page` | Page View | 1. `clinic_location` (String)<br>2. `city` (String)<br>3. `page_title` (String) | **Report:** Engagement > Pages and screens<br>**Audience:** "Local Clinic Intent" (Segmented by location for local search campaigns) |
| `blog_article_scroll` | Custom Event | 1. `article_title` (String)<br>2. `scroll_percentage` (Integer)<br>3. `time_on_page` (Integer) | **Report:** Engagement > Events<br>**Audience:** "Engaged Readers" (Users reading >75% of blog content) |

---

## 2. Multi-Step Booking Form Funnel Tracking

### The Problem:
GTM cannot natively understand step progression in JavaScript-driven multi-step forms (e.g. standard WordPress element toggling or Single Page Application forms) without custom assistance. Listening only to "form submits" or button clicks leads to false positives (validation errors) and misses drop-off locations.

### The Solution:
We brief the front-end developers to push a custom event (`booking_step_complete`) to the `dataLayer` at the successful transition of each step. GTM listens to this event and passes the step variables to GA4.

### Step 1: Select Clinic Location + Specialty
**Fires when:** User selects a clinic and specialty, then clicks "Next" (validations passed).
```json
{
  "event": "booking_step_complete",
  "step_number": 1,
  "step_name": "location_specialty_selected",
  "clinic_location": "Indiranagar, Bengaluru",
  "specialty": "Joint Replacement"
}
```

### Step 2: Enter Name + Phone + Preferred Date
**Fires when:** User fills out contact details and preferred date, then clicks "Next" (validations passed).
```json
{
  "event": "booking_step_complete",
  "step_number": 2,
  "step_name": "patient_details_entered",
  "clinic_location": "Indiranagar, Bengaluru",
  "specialty": "Joint Replacement",
  "preferred_date": "2026-07-10"
}
```

### Step 3: Confirm Booking (Final Submission)
**Fires when:** User clicks "Confirm Booking", form successfully writes to DB, and thank-you screen appears.
```json
{
  "event": "booking_step_complete",
  "step_number": 3,
  "step_name": "booking_confirmed",
  "clinic_location": "Indiranagar, Bengaluru",
  "specialty": "Joint Replacement",
  "booking_id": "BK-2026-9874",
  "status": "success"
}
```

### How to Surface Funnel Drop-off in GA4:
1. **GTM Setup:**
   - Create a Custom Event Trigger in GTM that fires on `booking_step_complete`.
   - Create Data Layer Variables for: `step_number`, `step_name`, `clinic_location`, and `specialty`.
   - Create a GA4 Event Tag mapped to the trigger, passing these variables as parameters.
2. **GA4 Funnel Exploration Setup:**
   - Go to **Explore** > **Funnel Exploration**.
   - Set up the steps:
     - **Step 1:** Event Name = `booking_step_complete` AND `step_number` = 1
     - **Step 2:** Event Name = `booking_step_complete` AND `step_number` = 2
     - **Step 3:** Event Name = `booking_step_complete` AND `step_number` = 3
   - GA4 will display a visual bar chart showing the drop-off conversion rate between steps.

---

## 3. Google Ads Conversion Import Recommendation

### Selection: `booking_step_complete` (Step 3: `booking_confirmed`)
We import **only** the final conversion step (`step_number` = 3) into Google Ads as our primary conversion action.

### Why this one over others?
1. **Business Value Alignment:** Step 3 represents a confirmed booking (qualified, high-intent lead). Importing earlier steps (like starting Step 1) optimizes campaigns for clickers rather than bookers.
2. **Smart Bidding Efficiency:** Google Ads Smart Bidding (Target CPA / Maximize Conversions) performs best when optimizing for the exact target action. Optimizing for micro-conversions (e.g. Call clicks or Step 1 starts) would flood the algorithm with lower-intent signals, leading to high ad spend on poor-quality traffic.
3. **Data Hygiene:** Avoids double-counting. If a user starts and stops, we only pay and optimize for their completed booking.
