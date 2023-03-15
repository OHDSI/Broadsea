define([], function () {
	var configLocal = {};

	// clearing local storage otherwise source cache will obscure the override settings
	localStorage.clear();

	var getUrl = window.location;
	var baseUrl = getUrl.protocol + "//" + getUrl.host;
	
	// WebAPI
	configLocal.api = {
		name: "$ATLAS_INSTANCE_NAME",
		url: baseUrl + '/WebAPI/'
	};

	configLocal.cohortComparisonResultsEnabled = $ATLAS_COHORT_COMPARISON_RESULTS_ENABLED;
	configLocal.userAuthenticationEnabled = $ATLAS_USER_AUTH_ENABLED;
	configLocal.plpResultsEnabled = $ATLAS_PLP_RESULTS_ENABLED;

	configLocal.authProviders = [{
		"name": "$ATLAS_SECURITY_PROVIDER_NAME",
		"url": "user/login/$ATLAS_SECURITY_PROVIDER_TYPE",
		"ajax": $ATLAS_SECURITY_USE_AJAX,
		"icon": "fa $ATLAS_SECURITY_ICON",
		"isUseCredentialsForm": $ATLAS_SECURITY_USE_FORM
	}];

	return configLocal;
});
