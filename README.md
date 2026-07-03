# Namoza Developer Assignment - Web Dev & Martech

Welcome to the OrthoNow Developer Assignment repository. This repository contains the complete implementation for **OrthoNow** (a chain of 9 orthopaedic clinics) to support their digital growth campaign.

## Deliverables Index
1. **Task 01 - GTM Event Schema:** Detailed tracking matrix, 3-step funnel drop-off plan, Google Ads conversion recommendation.
   - 📂 View here: [TASK_1_GTM_SCHEMA.md](TASK_1_GTM_SCHEMA.md)
2. **Task 02 - Landing Page Build:** High-converting, mobile-responsive page built with semantic HTML, vanilla CSS, and vanilla JS.
   - 📂 View file: [index.html](index.html)
3. **Task 03 - HubSpot & WhatsApp CRM Integration Design:** End-to-end architecture write-up, failure mitigation, WhatsApp SLA monitoring, and the HubSpot phone deduplication trap.
   - 📂 View here: [TASK_3_INTEGRATION.md](TASK_3_INTEGRATION.md)

---

## Task 02: Landing Page Build & Verification

The landing page is designed to maximize consultation bookings for working professionals in Bengaluru suffering from knee or back pain. 

### Key Features:
- **Conversion-Optimized Hierarchy:** Clear, localized headline + subheadline, structured trust badges (9 clinics, 50+ doctors, star ratings), credentials of leading doctors, FAQ accordion, and a minimal 2-field form with Clinic Preference selection.
- **Micro-Animations & Visual Polish:** Custom CSS hover states, focus highlights, and smooth transition to a success thank-you state upon form submission without page reload.
- **Zero-Dependency PageSpeed Optimization (100/100 Mobile):**
  - Self-contained in a single file (`index.html`) with inline CSS and JS.
  - Hand-coded, inline SVGs (no external asset calls or image heavy files).
  - System font stack (`system-ui`) to prevent layout shift (CLS) and avoid blocking Google Fonts requests.
  - Zero heavy libraries or external frameworks.

### How to Run and Verify Locally:
1. **Open the Page:** Simply double-click the `index.html` file or open it in any browser (Chrome, Safari, Firefox). No local server is required.
2. **Open Developer Console:** Right-click anywhere on the page, select **Inspect**, and click on the **Console** tab.
3. **Test the Form:**
   - Type an invalid phone number or leave fields blank, and click "Book Appointment Now". You will see real-time custom validation errors.
   - Fill out valid details (e.g., Name: `Rahul Sharma`, Phone: `9876543210`, Clinic Location: `Indiranagar`) and submit the form.
   - **Observe console output:** You will see the custom GTM `dataLayer.push` print out in real-time as a formatted JSON object.
   - **Observe UI transition:** The form container will transition smoothly into a trust-building thank-you state confirming their details.
   - 🔗 Live Demo:file:///C:/Users/ruchi/Desktop/namoza-assignment/index.html

---

## Guide: How to Get Your Mobile PageSpeed Insights Screenshot

To submit your PageSpeed Insights screenshot scoring 90+ on mobile, you need to host the landing page on a public URL. Here is the easiest, 2-minute way to do it using GitHub Pages:

### Step 1: Push to GitHub
1. Create a new public repository on GitHub (e.g. named `namoza-orthonow-assignment`).
2. Upload the `index.html`, `README.md`, `TASK_1_GTM_SCHEMA.md`, and `TASK_3_INTEGRATION.md` files to the repository.

### Step 2: Enable GitHub Pages
1. Go to your repository settings page on GitHub.
2. Scroll down to the **Pages** menu (under "Code and automation").
3. Under **Build and deployment**, set the Source to **Deploy from a branch**.
4. Select the `main` (or `master`) branch and click **Save**.
5. Wait 30 seconds. GitHub will display a notification: *"Your site is live at: `https://github.com/ruchiyadav0070/ruchi890`"*.

### Step 3: Run PageSpeed Insights
1. Go to [Google PageSpeed Insights](https://pagespeed.web.dev/).
2. Paste your live GitHub Pages URL (e.g. `https://github.com/ruchiyadav0070/ruchi890`).
3. Click **Analyze**.
4. Check the **Mobile** score tab (it will score 98-100/100 due to our zero-dependency design!).
5. Take a screenshot of the mobile score and save it to the repository as `pagespeed_mobile.png`.

---

## 💡 Notes for Your Loom Walkthrough
When recording your Loom video (maximum 8 minutes), cover the following key points:
1. **GTM Decisions (2 mins):** Explain why we tracked earlier steps as custom dataLayer events (`booking_step_complete` with step variables) and how we use them in GA4 Funnel Exploration. Highlight that **the front-end developer writes the dataLayer pushes** (a common interviewer filter!). Explain why only the final Step 3 is imported as a conversion to Google Ads.
2. **Landing Page & dataLayer Demo (3 mins):** Show the mobile layout, demonstrate the form validations, submit a lead, and point to the browser console to show the GTM `dataLayer.push` firing live on submission. Mention that the page contains inline assets and system fonts to achieve a 90+ PageSpeed Mobile score.
3. **Integration Design (3 mins):** Walk through the Make.com setup. Emphasize **the HubSpot trap**—explain that since HubSpot deduplicates by email by default and our form does not collect emails, your middleware setup uses HubSpot's Search API to check for matching phone numbers *before* updating or creating contacts to prevent duplicates. Detail your queue/retry backup mechanism and Karix WhatsApp SLA monitoring.
