package org.springframework.security.oauth2.provider;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNotSame;
import static org.junit.Assert.fail;

import java.net.URI;

import org.junit.Rule;
import org.junit.Test;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.gargoylesoftware.htmlunit.BrowserVersion;
import com.gargoylesoftware.htmlunit.FailingHttpStatusCodeException;
import com.gargoylesoftware.htmlunit.WebClient;
import com.gargoylesoftware.htmlunit.html.HtmlForm;
import com.gargoylesoftware.htmlunit.html.HtmlPage;
import com.gargoylesoftware.htmlunit.html.HtmlSubmitInput;
import com.gargoylesoftware.htmlunit.html.HtmlTextInput;

/**
 * @author Ryan Heaton
 * @author Dave Syer
 */
public class TestImplicitProvider {

	@Rule
	public ServerRunning serverRunning = ServerRunning.isRunning();

	/**
	 * tests the basic implicit provider
	 */
	@Test
	public void testBasicImplicitProvider() throws Exception {

		WebClient userAgent = new WebClient(BrowserVersion.FIREFOX_3);
		userAgent.setRedirectEnabled(false);

		URI uri = serverRunning.buildUri("/sparklr2/oauth/authorize").queryParam("response_type", "token")
				.queryParam("state", "mystateid").queryParam("client_id", "my-less-trusted-client")
				.queryParam("redirect_uri", "http://anywhere").queryParam("scope", "read").build();
		String location = null;
		try {
			userAgent.getPage(uri.toString());
			fail("should have been redirected to the login form.");
		} catch (FailingHttpStatusCodeException e) {
			location = e.getResponse().getResponseHeaderValue("Location");
		}

		HtmlPage loginPage = userAgent.getPage(location);
		// should be directed to the login screen...
		HtmlForm loginForm = loginPage.getFormByName("loginForm");
		((HtmlTextInput) loginForm.getInputByName("j_username")).setValueAttribute("marissa");
		((HtmlTextInput) loginForm.getInputByName("j_password")).setValueAttribute("koala");
		try {
			((HtmlSubmitInput) loginForm.getInputByName("login")).click();
			fail("should have been redirected to the authorization endpoint.");
		} catch (FailingHttpStatusCodeException e) {
			location = e.getResponse().getResponseHeaderValue("Location");
		}

		try {
			userAgent.getPage(location);
			fail("should have been redirected to the redirect page.");
		} catch (FailingHttpStatusCodeException e) {
			location = e.getResponse().getResponseHeaderValue("Location");
		}

		URI redirection = serverRunning.buildUri(location).build();
		assertEquals("anywhere", redirection.getHost());
		assertEquals("http", redirection.getScheme());

		// we've got the access token.
		String fragment = redirection.getFragment();
		assertNotNull("No fragment in redirect: "+redirection, fragment);
		
		String accessToken = null;
		Long expiresIn = null;
		String tokenType = null;
		String[] parameters = fragment.split("&");
		for (String parameter : parameters) {
			String[] s=parameter.split("=");
			String name=s[0];
			String value=s[1];
			if (name.equals("access_token")) {
				accessToken = value;
			} else if (name.equals("expires_in")) {
				expiresIn = Long.valueOf(value);
			} else if (name.equals("token_type")) {
				tokenType = value;
			}
		}

		assertNotNull(tokenType);
		assertNotNull(expiresIn);
		
		// now try and use the token to access a protected resource.
		// first make sure the resource is actually protected.
		assertNotSame(HttpStatus.OK, serverRunning.getStatusCode("/sparklr2/photos?format=json"));

		// now make sure an authorized request is valid.
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", String.format("%s %s", OAuth2AccessToken.BEARER_TYPE, accessToken));
		assertEquals(HttpStatus.OK, serverRunning.getStatusCode("/sparklr2/photos?format=json", headers));
	}
	
	/**
	 * tests the basic implicit provider
	 */
	@Test
	public void testPostForToken() throws Exception {

		HttpHeaders headers = new HttpHeaders();
		ResponseEntity<Void> result;

		MultiValueMap<String, String> formData;
		formData = new LinkedMultiValueMap<String, String>();
		formData.add("j_username", "marissa");
		formData.add("j_password", "koala");

		String location = "/sparklr2/login.do";
		result = serverRunning.postForStatus(location, headers, formData);
		assertEquals(HttpStatus.FOUND, result.getStatusCode());
		String cookie = result.getHeaders().getFirst("Set-Cookie");

		assertNotNull("Expected cookie in " + result.getHeaders(), cookie);
		headers.set("Cookie", cookie);

		location = "/sparklr2/oauth/authorize";
		formData = new LinkedMultiValueMap<String, String>();
		formData.add("response_type", "token");
		formData.add("state", "mystateid");
		formData.add("client_id", "my-less-trusted-client");
		formData.add("redirect_uri", "http://anywhere");
		formData.add("scope", "read");
		
		result = serverRunning.postForStatus(location, headers, formData);
		assertEquals(HttpStatus.FOUND, result.getStatusCode());

		location = result.getHeaders().getLocation().toString();
		System.err.println(location);
		URI redirection = serverRunning.buildUri(location).build();
		assertEquals("anywhere", redirection.getHost());
		assertEquals("http", redirection.getScheme());

		// we've got the access token.
		String fragment = redirection.getFragment();
		assertNotNull("No fragment in redirect: "+redirection, fragment);
		
	}

}
