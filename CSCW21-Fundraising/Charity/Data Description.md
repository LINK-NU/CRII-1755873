DonorsChoose Data Export Definition - Details
    Version: Unspecified
    Author: Donors Choose -  api-requests@donorschoose.org
    Date: 2016-12-30

## Donation Data Layout

All donations, including donor city, state, and partial-zip (when available). Each donation corresponds to a single classroom project so, for example, a donor can put 3 project donations in a check-out cart and pay for them with a single transaction.

> IDs

**_donationid**

**_projectid**

**donoracctid**

**_cartid:** can contain donations to multiple projects as well as gift card purchases.

>Donor Info

A few years back, donor addresses became optional, even when the donor is eligible to receive a mailed thank-you packet from the classroom. So there are a lot of null address fields for donors who elected not to provide their address.

**donor_city**

**donor_state**

**donor_zip:** The last two digits are hidden for privacy reasons.

**is_teacher_acct:** Donation was made by a teacher.

>Donation Times and Amounts

We don't publish exact donation amounts publicly as we believe many donors do not wish to share this information. Instead we've indicated the dollar amount range of the donation: <=$10, $10 to <=$100, >=$100.

**donation_timestamp**

**dollar_amount:** under_10, 10_to_100 or 100_and_up

**donation_included_optional_support:** More about our optional donation33. Note that this contribution is not optional for corporate or foundation donors, and is therefore always included in matching donations, for example.

>Payment Types

The fields below that are prefixed with payment_... indicate the source of funds used as payment for the donation. The payment_method gives the primary source of revenues for new donations. If payment_method given as 'no_cash_received', the donation consisted entirely of applying donation dollars that came into our system via a previous transaction. The remaining three boolean payment_included_... fields indicate the nature of those previous transactions.

When a gift card is used to make a donation, it's one of two scenarios. payment_included_campaign_gift_card is true when the gift card was issued as part of corporate or foundation giving campaign, or some other special promotional campaign. payment_included_web_purchased_gift_card is true when the gift was purchased by an individual donor through our public website. These web purchases are detailed in the Gift Cards data table.

Account credits may be created when a donor partially redeems a gift card, when they receive funds to spend because their donations were made to a project that expired without being fully funded, or because they're participating in our automatic monthly donations program. When these account credits are later used to make a donation, payment_included_acct_credit is true.

It is possible for a donation to include multiple payment types. For example, if a donor redeemed a gift card and added $10 dollars to make the donation, payment_included_campaign_gift_card would be true and payment_method would be creditcard.

**payment_method:** creditcard, paypal, amazon, check, double_your_impact_match, almost_home_match or no_cash_received.

The 2 'match' methods indicate if the donation was made by a Double Your Impact41 or an Almost Home26 account.

**payment_included_acct_credit**

**payment_included_campaign_gift_card**

**payment_included_web_purchased_gift_card**

The above 3 payment types are not mutually exclusive and forms of applying donation dollars that came into our system via a previous transaction. They can also be in addition to, or instead of, the primary payment_method type listed above.

We have done many large campaign- and promotion-based gift card distributions, you should expect to see many donations with payment_included_campaign_gift_card=True and payment_method=no_cash_received.

>Donation Types

Some additional donation attributes.

**via_giving_page:** True if the donation was made through a Giving Page27.
for_honoree: Donation included an honoree31.

**thank_you_packet_mailed:** All donors receive certain teacher thank-you's and photos6 of the project taking place. Donors who give >$100 or provide the project's completing donation, and supply us with their mailing address, receive a mailed thank-you packet7. This field indicates whether the donor was sent a thank-you packet for their donation.

## Project Data Layout

All classroom projects that have been posted to the site, including lots of school info such as its NCES ID (government-issued), lat/long, and city/state/zip. Each row in the table is a classroom project.

>IDs

_projectid: identifies a unique project
teacheracctid: identifies the teacher who created the project
_schoolid: identifies the school that this project is for
school_ncesid: the NCES ID of the school as used by 36http://nces.ed.gov/36

>School Location

These fields mostly correspond to the options available on our search page under the School section of "More Criteria." The options that are not available on the search page are latitude/longitude, zip, and metro type.

**school_latitude**

**school_longitude**

**school_city**

**school_state**

**school_zip:** 5 Digit Zip

**school_metro:** Urban, Suburban, or Rural

**school_district**

**school_county**

>School Types

These fields correspond to the options available on our search page under the School section of "More Criteria." The are flagged with 1 if the project is associated with the type of school specified, and a 0 if not. For example, a New Leaders New Schools affiliated school would have a 1 in the nlns field.

**school_charter**

**school_magnet**

**school_year_round**

**school_nlns**

**school_kipp**

**school_charter_ready_promise**

>Teacher Attributes

**teacher_prefix:** Dr., Mr., Mr. & Mrs., Mrs., Ms.

**teacher_teach_for_america**

**teacher_ny_teaching_fellow**

>Project Categories

These correspond the the details available on the bottom of each project page. Each project has a primary focus with a subject and associated area, but may also have a secondary focus. For example, a project requesting books about the environment may have a primary subject of "Environmental Science" under the area "Math & Science", with a secondary subject of "Literacy" under the area "Literacy & Language."

**primary_focus_subject**

**primary_focus_area**

**secondary_focus_subject**

**secondary_focus_area**

**resource_type:** Books, Technology, Supplies, Trips, Visitors, Other

**poverty_level:** high, low, minimal, unknown

**grade_level:** Grades PreK-2, Grades 3-5, Grades 6-8, Grades 9-12

>Project Pricing and Impact

These fields are available under Project Details on a project page, breaking down the cost of a project into its parts.

**vendor_shipping_charges**

**sales_tax**

**payment_processing_charges**

**fulfillment_labor_materials**

**total_price_excluding_opt_donation**

**total_price_including_opt_donation**

s**tudents_reached**

>Project Donations

These fields provide information about the donations made to a particular project.

**total_donations:** Total donation amount

**num_donors:** Number of unique donors giving to this project

**eligible_double_your_impact_match:** True if the project was ever eligible for a Double Your Impact41 match offer

**eligible_almost_home_match:** True if the project was ever eligible for an Almost Home26 match offer

>Project Status

These fields provide status information and dates for when a project reached their milestones. Dates will be null if the project did not reach that particular milestone. For example, if a project was posted but not completed, the date_completed would be null while the date_posted would have a date.

funding_status refers to the status of this project as of the date the dataset was created. Reallocated projects are projects that received partial funding but the project never completed, so the donations were moved towards another project. Completed projects refer to projects that received full funding. Expired projects are ones that expired before donations were made. Live projects are projects that were still open for donations on the day the dataset was created.

**funding_status:** Completed, Expired, Live, or Reallocated

**date_posted:** Date a project was approved by staff to be listed on the site

**date_completed:** Date a project become fully funded

**date_thank_you_packet_mailed:** Date that the project went through the final stage of sending out a thank you package to donors

**date_expiration:** Date the project was set to expire and be delisted from the site

## Resource Data Layout

All materials/resources requested for the classroom projects, including vendor name. Each record corresponds to a single requested material/resource from a specific vendor. Most classroom projects request multiple resources. Since the item name and other item info are provided by the vendors and used only for display purposes in our system, the formats are often inconsistent across vendors and over time.

**_resourceid**

**_projectid**

**vendorid:** An internal identifier in our system that can reliably be used to recognize resources requested/purchased from the same vendor across projects.
vendor_name

**project_resource_type:** The teacher-specified "resource type" to categorize the entire classroom project: Books, Technology, Supplies, Class Trips, Classroom Visitors.

**item_name**

**item_number**

**item_unit_price**

**item_quantity**

## Essay Data Layout

Full text of the teacher-written requests accompanying all classroom projects. The heart of each teacher's classroom project request is their written request, including a project title, a free-form essay or series of paragraphs answering a series of questions, and a summary of the materials/resources requested.

Originally, the site only accommodated a single free-form essay. Then we introduced more structure via series of questions. Eventually, the free-form essay was removed as an option. When possible, we've separated the essay into the four paragraphs that correspond to the series of questions.

**_projectid**

**teacheracctid**

**title**

**short_description:** Summary description, typically authored by the (volunteer) project screener by copy-pasting excerpts from the teacher's essay or paragraph answers.

**need_statement:** Summary of the materials/resources needed, eg. "My students need..."

**essay**

**paragraph1**

**paragraph2**

**paragraph3**

**paragraph4**

Before Feb 18, 2010, teachers had the option of writing free form or responding to these questions:

Paragraph 1 - Introduce Your Classroom

Paragraph 2 - Describe the Situation

Paragraph 3 - Describe the Solution

Paragraph 4 - Empower Your Donors

As of Feb 18, 2010, when the free-form essay option was removed as an option, the questions changed to these:

Paragraph 1 - Open with the challenge facing your students.

Paragraph 2 - Tell us more about your students.

Paragraph 3 - Inspire your potential donors with an overview of the resources you're requesting

Paragraph 4 - Close by sharing why your project is so important

## Giftcard Data Layout

All gift cards purchased by an individual donor through our public website11, including donor and recipient city, state, and partial-zip (when available). Does not include gift cards issued as part of corporate or foundation giving campaign, or some other special promotional campaign. If a website-purchased gift card was not redeemed before its 6-month expiration date, all its funds go to high-need classroom projects.

**_giftcardid**

**dollar_amount:** under_10, 10_to_100 or 100_and_up

**buyeracctid**

**buyer_city**

**buyer_state**

**buyer_zip:** The first 3 digits of the U.S. zip code.

**date_purchased**

**buyercartid:** The check-out cart in which the gift card was purchased.

**recipientacctid**

**recipient_city**

**recipient_state**

**recipient_zip:** The first 3 digits of the U.S. zip code.

**redeemed:** True if gift card was used to donate to a classroom project.

**date_redeemed**

**redeemedcartid:** The check-out cart in which the gift card was redeemed to support a classroom project.

Data Schema

