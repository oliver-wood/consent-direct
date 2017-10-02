# consent-direct

This is a proof-of-concept project.

## Executive Summary 

Consent.Direct hands over the power of consent management to the individual data subject, while providing data controllers the assurance that they are complying with the GDPR regulation to provide clear indications of their consent request, receiving a clear and unambiguous response and an easy route to withdraw consent at any time.


## How it would work 

### For the user:
At the point of request for consent by a specific organisation, a record will be lodged with Consent.Direct. The record will contain minimal information identifying the data subject (e.g. email address), and a record of their responses to the specific consent questions for the specific organisation. The consent form will be marked with the Consent.Direct branding.

For a data subject to manage their records, they can do any of the following:
•	Download the Consent.Direct smartphone app
•	Install the Consent.Direct web browser plugin
•	Access the Consent.Direct web site

The user will be required to identify themselves by receiving an email code at their specified address, or by entering a code sent by text message to their smartphone.

Once they have been identified, the user will be able to see a list of any consents that they have given previously, and will be provided with options to alter these consents.

If a user has an active browser plugin and encounters a form with consent options, the plugin will take over the duty of informing the user that they are being asked for consent and present the questions. The user will (optionally) be able to sign their responses with a private key by entering a private pin.

If the user has (an active browser plugin? and) active smartphone app and encounters a form with consent options, the smartphone app will be notified and take over the responsibility for informing the user that they are being asked for consent and present the questions. The user will be able to sign their responses with biometric identification or a private pin.

If the user encounters an Consent.Direct paper form, it should include a QR code that can be scanned by the smartphone app in order to present the consent questions, and selection and signing can continue as above.

### For the organisation: 

The organisation will need to first lodge their consent questions with Consent.Direct. Next, they will need to include some simple code in their data collection form to reveal the consent questions with the Consent.Direct branding and a link to the web site.

Finally, they will need to include some code in their backend systems to query the consent records as they are needed, for example, when generating a warm leads list to telephone.

## Data Storage

Consent records are stored on a decentralised ledger (blockchain) at many locations, including those of the data controller, the Consent.Direct organisation, some data subjects and potentially the Information Commissioner’s office. This removes the burden of trusting a centralised third-party to handle this sensitive data.

All data is encrypted or stored as hashes, so only available by comparison.
Data is immutable once it has been entered into the ledger. 
Data is timestamped by its block position.

