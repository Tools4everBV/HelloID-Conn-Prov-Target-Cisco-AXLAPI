# WSDL is not published, so we build the requests manually.
# https://developer.cisco.com/docs/axl-schema-reference/

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; #Enable TLS 1.2
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} ; #Skip Certificate Check

$version = "11.5";
$uri = "https://10.10.20.1/axl/";
$username = "administrator"
$password = "ciscopsdt";

$pair = "$($username):$($password)"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$key = "Basic $base64"


## List Users
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) listUser";
}

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
  <soapenv:Header />
  <soapenv:Body>
    <ns:listUser sequence=`"?`">
      <searchCriteria>
        <department>%</department>
      </searchCriteria>
      <returnedTags uuid=`"?`">
        <firstName>?</firstName>
        <displayName>?</displayName>
        <middleName>?</middleName>
        <lastName>?</lastName>
        <userid>?</userid>
        <primaryExtension>
          <pattern>?</pattern>
          <routePartitionName>?</routePartitionName>
        </primaryExtension>
      </returnedTags>
    </ns:listUser>
  </soapenv:Body>
</soapenv:Envelope>";

$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$users = ([xml]$response.Content).Envelope.body.listUserResponse.return.user





## List Phones
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) listPhone";
}

$attributeName = "description";
$attributeFilter = "%"

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:listPhone>
                     <searchCriteria>
                        <$($attributeName)>$($attributeFilter)</$($attributeName)>
                     </searchCriteria>
                     <returnedTags uuid=`"?`">
                        <name>?</name>
                        <description>?</description>
                        <product>?</product>
                        <model>?</model>
                        <protocol>?</protocol>
                        <callingSearchSpaceName uuid=`"?`">?</callingSearchSpaceName>
                        <devicePoolName uuid=`"?`">?</devicePoolName>
                        <networkLocation>?</networkLocation>
                        <locationName uuid=`"?`">?</locationName>
                        <securityProfileName uuid=`"?`">?</securityProfileName>
                        <sipProfileName uuid=`"?`">?</sipProfileName>
                        <phoneTemplateName uuid=`"?`">?</phoneTemplateName>
                        <primaryPhoneName uuid=`"?`">?</primaryPhoneName>
                        <isActive>?</isActive>
                     </returnedTags>
                  </ns:listPhone>
               </soapenv:Body>
            </soapenv:Envelope>"

$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$phones = ([xml]$response.Content).Envelope.body.listPhoneResponse.return.phone







## Get Phone

$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) getPhone";
}

$id = "{E0C1CEEE-175A-7F5A-8C62-675BE89E4F99}"
$idType = "uuid"

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:getPhone>
                     <$($idType)>$($id)</$($idType)>
                     <returnedTags uuid=`"?`">
                        <name>?</name>
                        <description>?</description>
                        <product>?</product>
                        <model>?</model>
                        <class>?</class>
                        <protocol>?</protocol>
                        <protocolSide>?</protocolSide>
                        <lines>
                           <line uuid=`"?`">
                              <index>?</index>
                              <label>?</label>
                              <display>?</display>
                              <dirn uuid=`"?`">
                                 <pattern>?</pattern>
                                 <routePartitionName uuid=`"?`">?</routePartitionName>
                              </dirn>
                              <ringSetting>?</ringSetting>
                              <consecutiveRingSetting>?</consecutiveRingSetting>
                              <ringSettingIdlePickupAlert>?</ringSettingIdlePickupAlert>
                              <ringSettingActivePickupAlert>?</ringSettingActivePickupAlert>
                              <displayAscii>?</displayAscii>
                              <e164Mask>?</e164Mask>
                              <dialPlanWizardId>?</dialPlanWizardId>
                              <mwlPolicy>?</mwlPolicy>
                              <maxNumCalls>?</maxNumCalls>
                              <busyTrigger>?</busyTrigger>
                              <callInfoDisplay>
                                 <callerName>?</callerName>
                                 <callerNumber>?</callerNumber>
                                 <redirectedNumber>?</redirectedNumber>
                                 <dialedNumber>?</dialedNumber>
                              </callInfoDisplay>
                              <recordingProfileName uuid=`"?`">?</recordingProfileName>
                              <monitoringCssName uuid=`"?`">?</monitoringCssName>
                              <recordingFlag>?</recordingFlag>
                              <audibleMwi>?</audibleMwi>
                              <speedDial>?</speedDial>
                              <partitionUsage>?</partitionUsage>
                              <associatedEndusers>
                                 <enduser>
                                    <userId>?</userId>
                                 </enduser>
                              </associatedEndusers>
                              <missedCallLogging>?</missedCallLogging>
                              <recordingMediaSource>?</recordingMediaSource>
                           </line>
                        </lines>
                        <callingSearchSpaceName uuid=`"?`">?</callingSearchSpaceName>
                        <devicePoolName uuid=`"?`">?</devicePoolName>
                        <commonDeviceConfigName uuid=`"?`">?</commonDeviceConfigName>
                        <commonPhoneConfigName uuid=`"?`">?</commonPhoneConfigName>
                        <networkLocation>?</networkLocation>
                        <locationName uuid=`"?`">?</locationName>
                        <mediaResourceListName uuid=`"?`">?</mediaResourceListName>
                        <networkHoldMohAudioSourceId>?</networkHoldMohAudioSourceId>
                        <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                        <automatedAlternateRoutingCssName uuid=`"?`">?</automatedAlternateRoutingCssName>
                        <aarNeighborhoodName uuid=`"?`">?</aarNeighborhoodName>
                        <loadInformation special=`"?`">?</loadInformation>
                        <traceFlag>?</traceFlag>
                        <mlppIndicationStatus>?</mlppIndicationStatus>
                        <preemption>?</preemption>
                        <useTrustedRelayPoint>?</useTrustedRelayPoint>
                        <retryVideoCallAsAudio>?</retryVideoCallAsAudio>
                        <securityProfileName uuid=`"?`">?</securityProfileName>
                        <sipProfileName uuid=`"?`">?</sipProfileName>
                        <cgpnTransformationCssName uuid=`"?`">?</cgpnTransformationCssName>
                        <useDevicePoolCgpnTransformCss>?</useDevicePoolCgpnTransformCss>
                        <geoLocationName uuid=`"?`">?</geoLocationName>
                        <geoLocationFilterName uuid=`"?`">?</geoLocationFilterName>
                        <sendGeoLocation>?</sendGeoLocation>
                        <numberOfButtons>?</numberOfButtons>
                        <phoneTemplateName uuid=`"?`">?</phoneTemplateName>
                        <primaryPhoneName uuid=`"?`">?</primaryPhoneName>
                        <ringSettingIdleBlfAudibleAlert>?</ringSettingIdleBlfAudibleAlert>
                        <ringSettingBusyBlfAudibleAlert>?</ringSettingBusyBlfAudibleAlert>
                        <userLocale>?</userLocale>
                        <networkLocale>?</networkLocale>
                        <idleTimeout>?</idleTimeout>
                        <authenticationUrl>?</authenticationUrl>
                        <directoryUrl>?</directoryUrl>
                        <idleUrl>?</idleUrl>
                        <informationUrl>?</informationUrl>
                        <messagesUrl>?</messagesUrl>
                        <proxyServerUrl>?</proxyServerUrl>
                        <servicesUrl>?</servicesUrl>
                        <softkeyTemplateName uuid=`"?`">?</softkeyTemplateName>
                        <loginUserId>?</loginUserId>
                        <defaultProfileName uuid=`"?`">?</defaultProfileName>
                        <enableExtensionMobility>?</enableExtensionMobility>
                        <currentProfileName uuid=`"?`">?</currentProfileName>
                        <loginTime>?</loginTime>
                        <loginDuration>?</loginDuration>
                        <currentConfig>
                           <userHoldMohAudioSourceId>?</userHoldMohAudioSourceId>
                           <phoneTemplateName uuid=`"?`">?</phoneTemplateName>
                           <mlppDomainId>?</mlppDomainId>
                           <mlppIndicationStatus>?</mlppIndicationStatus>
                           <preemption>?</preemption>
                           <softkeyTemplateName uuid=`"?`">?</softkeyTemplateName>
                           <ignorePresentationIndicators>?</ignorePresentationIndicators>
                           <singleButtonBarge>?</singleButtonBarge>
                           <joinAcrossLines>?</joinAcrossLines>
                           <callInfoPrivacyStatus>?</callInfoPrivacyStatus>
                           <dndStatus>?</dndStatus>
                           <dndRingSetting>?</dndRingSetting>
                           <dndOption>?</dndOption>
                           <alwaysUsePrimeLine>?</alwaysUsePrimeLine>
                           <alwaysUsePrimeLineForVoiceMessage>?</alwaysUsePrimeLineForVoiceMessage>
                           <emccCallingSearchSpaceName uuid=`"?`">?</emccCallingSearchSpaceName>
                           <deviceName>?</deviceName>
                           <model>?</model>
                           <product>?</product>
                           <deviceProtocol>?</deviceProtocol>
                           <class>?</class>
                        </currentConfig>
                        <singleButtonBarge>?</singleButtonBarge>
                        <joinAcrossLines>?</joinAcrossLines>
                        <builtInBridgeStatus>?</builtInBridgeStatus>
                        <callInfoPrivacyStatus>?</callInfoPrivacyStatus>
                        <hlogStatus>?</hlogStatus>
                        <ownerUserName uuid=`"?`">?</ownerUserName>
                        <allowCtiControlFlag>?</allowCtiControlFlag>
                        <presenceGroupName uuid=`"?`">?</presenceGroupName>
                        <unattendedPort>?</unattendedPort>
                        <requireDtmfReception>?</requireDtmfReception>
                        <rfc2833Disabled>?</rfc2833Disabled>
                        <certificateOperation>?</certificateOperation>
                        <authenticationMode>?</authenticationMode>
                        <keySize>?</keySize>
                        <keyOrder>?</keyOrder>
                        <ecKeySize>?</ecKeySize>
                        <authenticationString>?</authenticationString>
                        <certificateStatus>?</certificateStatus>
                        <upgradeFinishTime>?</upgradeFinishTime>
                        <deviceMobilityMode>?</deviceMobilityMode>
                        <roamingDevicePoolName uuid=`"?`">?</roamingDevicePoolName>
                        <remoteDevice>?</remoteDevice>
                        <dndOption>?</dndOption>
                        <dndRingSetting>?</dndRingSetting>
                        <dndStatus>?</dndStatus>
                        <isActive>?</isActive>
                        <isDualMode>?</isDualMode>
                        <mobilityUserIdName uuid=`"?`">?</mobilityUserIdName>
                     </returnedTags>
                  </ns:getPhone>
               </soapenv:Body>
            </soapenv:Envelope>";

$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$Phone = ([xml]$response.Content).Envelope.body.getPhoneResponse.return.phone









## Get Lines
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) listLine";
}


$attributeName = "description";
$attributeFilter = "%"

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:listLine sequence=`"?`">
                     <searchCriteria>
                        <$($attributeName)>$($attributeFilter)</$($attributeName)>
                     </searchCriteria>
                     <returnedTags uuid=`"?`">
                        <pattern>?</pattern>
                        <description>?</description>
                        <usage>?</usage>
                        <routePartitionName uuid=`"?`">?</routePartitionName>
                        <alertingName>?</alertingName>
                        <asciiAlertingName>?</asciiAlertingName>
                        <cfaCssPolicy>?</cfaCssPolicy>
                        <associatedDevices>
                           <device>?</device>
                        </associatedDevices>
                     </returnedTags>
                  </ns:listLine>
               </soapenv:Body>
            </soapenv:Envelope>";
$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$Lines = ([xml]$response.Content).Envelope.body.listLineResponse.return.line








## Get Line
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) getLine";
}


$uuid = "{CB9AD530-406C-D0F6-C2D9-6BEF5EC5B120}"

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/11.0`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:getLine sequence=`"?`">
                     <uuid>$($uuid)</uuid>
                     <returnedTags uuid=`"?`">
                        <pattern>?</pattern>
                        <description>?</description>
                        <usage>?</usage>
                        <routePartitionName uuid=`"?`">?</routePartitionName>
                        <alertingName>?</alertingName>
                        <asciiAlertingName>?</asciiAlertingName>
                        <cfaCssPolicy>?</cfaCssPolicy>
                        <defaultActivatedDeviceName uuid=`"?`">?</defaultActivatedDeviceName>
                        <active>?</active>
                     </returnedTags>
                  </ns:getLine>
               </soapenv:Body>
            </soapenv:Envelope>";

$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$Line = ([xml]$response.Content).Envelope.body.getLineResponse.return.line









## Get Route Points
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) listCtiRoutePoint";
}

$attributeName = "name";
$attributeFilter = "%";

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:listCtiRoutePoint sequence=`"?`">
                     <searchCriteria>
                        <$($attributeName)>$($attributeFilter)</$($attributeName)>
                     </searchCriteria>
                     <returnedTags uuid=`"?`">
                        <name>?</name>
                        <description>?</description>
                        <product>?</product>
                        <model>?</model>
                     </returnedTags>
                  </ns:listCtiRoutePoint>
               </soapenv:Body>
            </soapenv:Envelope>";


$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$RoutePoints = ([xml]$response.Content).Envelope.body.listCtiRoutePointResponse.return.ctiRoutePoint




## Get Route Point
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) getCtiRoutePoint";
}

$uuid = "{C2D43209-D08B-041D-391C-0A87C5CA7F2B}"

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:getCtiRoutePoint sequence=`"?`">
                     <uuid>$($uuid)</uuid>
                     <returnedTags uuid=`"?`">
                        <name>?</name>
                        <description>?</description>
                        <product>?</product>
                        <model>?</model>
                        <lines>
                           <line uuid=`"?`">
                              <index>?</index>
                              <label>?</label>
                              <display>?</display>
                              <dirn uuid=`"?`">
                                 <pattern>?</pattern>
                                 <routePartitionName uuid=`"?`">?</routePartitionName>
                              </dirn>
                           </line>
                        </lines>
                     </returnedTags>
                  </ns:getCtiRoutePoint>
               </soapenv:Body>
            </soapenv:Envelope>";
$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST
$RoutePoint = ([xml]$response.Content).Envelope.body.getCtiRoutePointResponse.return.ctiRoutePoint



##Create Route Point
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) addCtiRoutePoint";
}

$name = "TestNewRP01"
$description = "This is a test";
$devicePoolName = "default";
$locationName = "Hub_None";


$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:addCtiRoutePoint sequence=`"?`">
                     <ctiRoutePoint>
                        <name>$($name)</name>
                        <description>$($description)</description>
                        <product>CTI Route Point</product>
                        <class>CTI Route Point</class>
                        <model>CTI Route Point</model>
                        <protocol>SCCP</protocol>
                        <protocolSide>User</protocolSide>
                        <devicePoolName>$($devicePoolName)</devicePoolName>
                        <locationName>$($locationName)</locationName>
                       
                        <useTrustedRelayPoint>Default</useTrustedRelayPoint>
                        
                     </ctiRoutePoint>
                  </ns:addCtiRoutePoint>
               </soapenv:Body>
            </soapenv:Envelope>";
$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST






## Update Line (Not Tested)
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) updateLine";
}

$pattern = "";
$description = "";
$alertingName = "";
$asciiAlertingName = "";
$active = "";

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:updateLine sequence=`"?`">
                     <pattern>$($pattern)</pattern>
                     <description>$($description)</description>
                     <alertingName>$($alertingName)</alertingName>
                     <asciiAlertingName>$($asciiAlertingName)</asciiAlertingName>
                     <active>$($active)</active>
                  </ns:updateLine>
               </soapenv:Body>
            </soapenv:Envelope>";

$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST



## Update Phone (Not Tested)
$headers = @{
                Authorization = $key;
                SOAPAction = "CUCM:DB ver=$($version) updatePhone";
}

$uuid = "";
$description = "";

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:ns=`"http://www.cisco.com/AXL/API/$($version)`">
               <soapenv:Header/>
               <soapenv:Body>
                  <ns:updatePhone sequence=`"?`">
                     <uuid>$($uuid)</uuid>
                     <description>$($description)</description>
                  </ns:updatePhone>
               </soapenv:Body>
            </soapenv:Envelope>";

$response = Invoke-WebRequest -Uri $uri -ContentType "text/xml" -Headers $headers -Body $body -Method POST

