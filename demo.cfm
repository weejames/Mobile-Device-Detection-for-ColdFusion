<cfset mobileDetection = CreateObject("component", "mobileDetection").init() />

<cfif mobileDetection.isMobile()>
	Mobile device
<cfelse>
	Non-mobile device
</cfif>