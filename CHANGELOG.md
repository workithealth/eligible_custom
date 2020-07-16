# Changelog

## 3.0.0.beta17 - 2020-07-13
  - Added support for report API endpoints

## 3.0.0.beta16 - 2020-07-10
  - Migrated "Patient" endpoint to "PatientRecord" 

## 3.0.0.beta15 - 2020-06-12
  - Added support for patient questionnaire, patient questions API endpoints

## 3.0.0.beta14 - 2020-06-08
  - Added Fee and FeeRefund new REST API endpoints

## 3.0.0.beta13 - 2020-06-05
  - Added create, update, delete and validate endpoints support for rules

## 3.0.0.beta12 - 2020-05-12
  - Updated pinned GDS SSL certificate

## 3.0.0.beta11 - 2020-05-12
  - Added summary and escalate actions for Enrollments endpoint
  - Added Action endpoint
  - Added Attribute endpoint
  - Added Claim endpoint
  - Added ClaimServiceLine endpoint
  - Added Device endpoint
  - Added Discount endpoint
  - Renamed FileObject to File in order to kept consistency
  - Added FileLink endpoint
  - Added InsuranceCompanyAlias endpoint
  - Added PaymentReport endpoint
  - Added Remark endpoint
  - Added Rule endpoint
  - Added Session endpoint
  - Added Transaction endpoint
  - Added ValueList endpoint
  - Added ValueListItem endpoint
  - Added Verification endpoint
  - Updated Charge endpoint to raise exception on delete action
  - Updated Estimate endpoint, raise exception on update and delete actions, and added missing actions process, reestimate, convert
  - Update EstimateServiceLine endpoint to raise exception on update and delete actions
  - Updated InsuranceCompany endpoint to raise exception on delete action

## 3.0.0.beta10 - 2020-05-06
  - Added support for new REST API endpoints "Contract, Enrollment, Provider"
  - Added support delete operations on new API.

## 3.0.0.beta9 - 2020-05-04
  - Added support for new REST API endpoints "Charge, Estimate, EstimateServiceLine, Product, Treatment"

## 3.0.0.beta8 - 2020-04-30
  - Fixed payment and payment_reports API urls for new PatientStatement endpoint

## 3.0.0.beta7 - 2020-04-16
  - Removed un-wanted parameters from the API request while making calls to new REST API endpoint

## 3.0.0.beta6 - 2020-04-08
  - Bug fix for "PatientStatement" endpoint

## 3.0.0.beta5 - 2020-03-31
  - Added support for new REST API endpoints "Insurance Company, Insurance Policy, Patient"

## 3.0.0.beta4 - 2020-03-16
  - Fixed query params conversion to support Expand feature for new REST API Endpoints
  - Changed new REST API endpoints format to support `ID` field or `params`

## 3.0.0.beta3 - 2020-03-09
  - Added support for new REST API endpoint "PatientStatement" and "PatientStatementServiceLine"

## 3.0.0.beta2 - 2020-03-03
  - Added support for V1.0 REST API endpoints and added Files endpoints
  - Update pinned api.eligible.com and wildcard.eligible.com certificate

## 3.0.0.beta1 - 2019-10-01
  - Added support for Eligible-Account Header in the API requests when used Eligible Connect feature

## 2.9.9 - 2019-08-07
  - Added Icd code endpoints

## 2.9.8 - 2019-06-24
  - Added an endpoint to fetch Risk Assessment

## 2.9.7 - 2019-03-08
  - Updated GDS SSL certificate

## 2.9.6 - 2018-07-17
  - Added Risk Assessment endpoints

## 2.9.5 - 2018-07-06
  - Added Mix and Match support for coverage requests

## 2.9.4 - 2018-04-25
  - Rename endpoint provider_detail to provider_model

## 2.9.3 - 2018-04-19
  - Added new endpoints visit types, provider details

## 2.9.2 - 2018-03-26
  - We can use session token or api_key for making a Eligible Call
  - for session token supported endpoints

## 2.9.0 - 2017-10-04
  - Adding revoke functionality for session tokens

## 2.8.2 - 2017-03-24
  - Upgraded internal rest-client dependency to 2.0.0 and higher

## 2.8.1 - 2017-02-23
  - Upgraded internal rest-client dependency to 2.0.1
  - Fixes mime-type dependency issue with newer Rails projects

## 2.8.0 - 2017-02-23
  - Added support for session tokens

## 2.7.0 - 2016-12-14
  - Changed default content type to application/json

## 2.6.3 - 2016-11-18
  - Added a new certificate fingerprint

## 2.6.2 - 2016-08-31
  - New APIs added in testing mode, no public-facing changes

## 2.6.1 - 2016-05-10
  - Suppressing ssl_verify_callback return code warning
  - Added new endpoints: received_pdf, precert and referral
  - Refactored the code and fixed couple of bugs
  - Documentation updates for the endpoints

## 2.6.0 - 2016-02-23
  - Added new endpoints customer, original signature pdf and payer.
  - Added specs
  - Bumped api version to 1.5
  - Fixed few bugs

## 2.5.0 - 2016-01-07
  - Added certificate pinning
  - Added rubocop and fixed style/linting/metrics issues
  - Migrated from outdated test-unit/mocha to current rspec for test suite

## 2.4
  - Refactoring Code
  - More test cases
  - Removed legacy endpoint for *plans*, *coverage* should be used instead.
  - Removed legacy endpoint for *services*, *coverage* should be used instead.
  - List of contributors and documentation updated.
  - Gemfile updated, dependencies updated as well.
  - Removed json gem in favor of multi_json
  - Fixed the code to let the users make x12 requests at anytime.
  - New endpoint for Tickets

## 2.3
  - New endpoint for Batch

## 2.2
  - New endpoint for x12 POST

## 2.1
  - New endpoint for payment status

## 2.0
  - Additional endpoints for claims, enrollments, and coverage

## 1.1
  - Additional endpoints for service/general and service/list
  - Support x12 format in params

## 1.0
  - Initial release
