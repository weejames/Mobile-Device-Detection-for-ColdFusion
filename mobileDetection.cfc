<cfcomponent name="mobileDetection" hint="Implements an algorithm to detect if the current user is using a mobile device">

	<cfset this.uaPrefixes = ['w3c ', 'w3c-', 'acs-', 'alav', 'alca', 'amoi', 'audi', 'avan', 'benq', 'bird', 'blac', 'blaz', 'brew', 'cell', 'cldc', 'cmd-', 'dang', 'doco', 'eric', 'hipt', 'htc_', 'inno', 'ipaq', 'ipod', 'jigs', 'kddi', 'keji', 'leno', 'lg-c', 'lg-d', 'lg-g', 'lge-', 'lg/u', 'maui', 'maxo', 'midp', 'mits', 'mmef', 'mobi', 'mot-', 'moto', 'mwbp', 'nec-', 'newt', 'noki', 'palm', 'pana', 'pant', 'phil', 'play', 'port', 'prox', 'qwap', 'sage', 'sams', 'sany', 'sch-', 'sec-', 'send', 'seri', 'sgh-', 'shar', 'sie-', 'siem', 'smal', 'smar', 'sony', 'sph-', 'symb', 't-mo', 'tosh', 'teli','tim-', 'tsm-', 'upg1', 'upsi', 'vk-v', 'voda', 'wap-', 'wapa', 'wapi', 'wapp', 'wapr', 'webc', 'winw', 'winw', 'xda ', 'xda-'] />
  
	<cfset this.deviceSignatures = ['android', 'blackberry', 'hiptop', 'ipod', 'lge vx', 'midp', 'maemo', 'mmp', 'netfront', 'nintendo DS', 'novarra', 'openweb', 'opera mobi', 'opera mini', 'palm', 'psp', 'phone', 'smartphone', 'symbian', 'up.browser', 'up.link', 'wap', 'windows ce'] />
  
	<cffunction name="init" access="public" output="false" hint="Constructor" returntype="mobileDetection">    
		<cfreturn this />
	</cffunction>
  
	<cffunction name="isMobile" access="public" output="false" hint="Return boolean to identify if current device is a mobile or not" returntype="Boolean">
		<cfset var isMobileDevice = false />

		<cfset isMobileDevice = this.wapDetection() />    
		<cfif !isMobileDevice><cfset isMobileDevice = this.checkUserAgentPrefix() /></cfif>
		<cfif !isMobileDevice><cfset isMobileDevice = this.checkUserAgentContains() /></cfif>

		<cfreturn isMobileDevice />
	</cffunction>
  
	<cffunction name="wapDetection" access="package">
		<cfset var kk = false />
	
		<cfloop index="kk" list="HTTP_X_WAP_PROFILE,HTTP_PROFILE">
			<cfif isDefined("CGI.#kk#") and len(CGI[kk])>
				<cfreturn true />
			</cfif>
		</cfloop>

		<cfif isDefined("CGI.HTTP_ACCEPT") and lcase(CGI.HTTP_ACCEPT) contains "wap">
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>
  
	<cffunction name="checkUserAgentPrefix" access="package">
		<cfif isDefined("CGI.HTTP_USER_AGENT")>

			<cfset var signature = lcase(Left(CGI.HTTP_USER_AGENT, 4)) />

			<cfset var agentList = ArrayToList(this.uaPrefixes) />

			<cfif ListContainsNoCase(agentList, signature)>
				<cfreturn true />
			</cfif>

		</cfif>

		<cfreturn false />
	</cffunction>
  
	<cffunction name="checkUserAgentContains" access="package">
		<cfset var kk = false />

		<cfif isDefined("CGI.HTTP_USER_AGENT")>

			<cfloop index="kk" list="#ArrayToList(this.deviceSignatures)#">
				<cfif CGI.HTTP_USER_AGENT contains kk>
					<cfreturn true />
				</cfif>
			</cfloop>

		</cfif>

		<cfreturn false />
	</cffunction>
  
	<cffunction name="checkOperamini" access="package">
		<cfif isDefined("CGI.ALL_HTTP") and lcase(CGI.ALL_HTTP) contains 'operamini'>
			<cfreturn true />
		</cfif>

		<cfreturn false />
	</cffunction>  
  
</cfcomponent>