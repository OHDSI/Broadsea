define([], function () {
	var configLocal = {};

	var getUrl = window.location;
	var baseUrl = getUrl.protocol + "//" + getUrl.host;
	
	// WebAPI
	configLocal.webAPIRoot = baseUrl + '/WebAPI/';
	configLocal.api = {
		name: "$ATLAS_INSTANCE_NAME",
		url: baseUrl + '/WebAPI/'
	};

	configLocal.useExecutionEngine = $ATLAS_USE_EXECUTION_ENGINE;
	configLocal.cohortComparisonResultsEnabled = $ATLAS_COHORT_COMPARISON_RESULTS_ENABLED;
	configLocal.userAuthenticationEnabled = $ATLAS_USER_AUTH_ENABLED;
	configLocal.plpResultsEnabled = $ATLAS_PLP_RESULTS_ENABLED;
	configLocal.disableBrowserCheck = $ATLAS_DISABLE_BROWSER_CHECK;
	
	configLocal.enableTaggingSection = $ATLAS_ENABLE_TAGGING_SECTION;
	configLocal.cacheSources = $ATLAS_CACHE_SOURCES;
	configLocal.pollInterval = $ATLAS_POLL_INTERVAL;
	configLocal.enableSkipLogin = $ATLAS_ENABLE_SKIP_LOGIN;
	configLocal.viewProfileDates = $ATLAS_VIEW_PROFILE_DATES;
	configLocal.enableCosts = $ATLAS_ENABLE_COSTS;
	configLocal.supportUrl = "$ATLAS_SUPPORT_URL";
	configLocal.supportMail = "$ATLAS_SUPPORT_MAIL";
	configLocal.feedbackContacts = "$ATLAS_FEEDBACK_CONTACTS";
	configLocal.feedbackCustomHtmlTemplate = "$ATLAS_FEEDBACK_CUSTOM_HTML_TEMPLATE";
	configLocal.companyInfoCustomHtmlTemplate = "$ATLAS_COMPANY_INFO_CUSTOM_HTML_TEMPLATE";
	configLocal.showCompanyInfo = $ATLAS_SHOW_COMPANY_INFO;
	configLocal.defaultLocale = "$ATLAS_DEFAULT_LOCALE";
	configLocal.enablePersonCount = $ATLAS_ENABLE_PERSON_COUNT;
	configLocal.enableTermsAndConditions = $ATLAS_ENABLE_TERMS_AND_CONDITIONS;

	configLocal.authProviders = [{
		"name": "$ATLAS_SECURITY_PROVIDER_NAME",
		"url": "user/login/$ATLAS_SECURITY_PROVIDER_TYPE",
		"ajax": $ATLAS_SECURITY_USE_AJAX,
		"icon": "fa $ATLAS_SECURITY_ICON",
		"isUseCredentialsForm": $ATLAS_SECURITY_USE_FORM
	}];

	return configLocal;
});
