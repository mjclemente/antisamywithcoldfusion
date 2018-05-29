<cfscript>
	factoryLoader = createObject( "component", "javaloaderfactory" ).init();

  jarArray = [
        expandPath('/lib/antisamy/antisamy-1.5.7.jar'),
        expandPath('/lib/antisamy/xercesImpl-2.9.1.jar'),
        expandPath('/lib/antisamy/xml-resolver-1.2.jar'),
        expandPath('/lib/antisamy/httpclient-4.3.6.jar'),
        expandPath('/lib/antisamy/batik-css-1.9.1.jar'),
        expandPath('/lib/antisamy/batik-util-1.9.1.jar'),
        expandPath('/lib/antisamy/xmlgraphics-commons-2.2.jar'),
        expandPath('/lib/antisamy/xml-apis-ext-1.3.04.jar'),
        expandPath('/lib/antisamy/nekohtml-1.9.22.jar')
  ];

	//use the factory to get an instance of the JavaLoader
	javaloader = factoryLoader.getJavaLoader( jarArray );

	//use the JavaLoader to create an AntiSamy instance
	antiSamy = javaLoader.create( 'org.owasp.validator.html.AntiSamy').init();

	//take your untrusted input
	unTrustedInput = fileRead( expandPath( '/untrusted.html') );

	errors = [];
	//define your policy file
	policyFile = expandPath( '/policy/antisamy-slashdot.xml' );

	//pass the untrusted input and policy file into your AntiSamy instance
	errors = antiSamy.scan( unTrustedInput, policyFile ).getErrorMessages();

	writeDump(errors);

	trustedInput = '';

	trustedInput = antiSamy.scan( unTrustedInput, policyFile ).getCleanHTML();
	writeDump(trustedInput);

</cfscript>