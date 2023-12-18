# Access Layer

`Access Layer` is the first layer where the users' request come to, and it also can be called as `gateway`. 

From the `function` perspective, `gateway` usually can be divided into 2 sub layers, one system-oriented and one business-oriented. But sometimes,  it's possible to have some overlaps between this two.

### System Gateway 

This type gateway providing functions such as,
* Load Balancing
* Access Control
* Request Forwarding
  * Routing (for example, IDC level routing)

### Business Oriented Gateway 

Which locates behind the previous one, and it focuses more on business related functions, including but not limited to:

* Request Oriented:
  * Request Cleaning. Request validation and normalization for example.
  * Authentication & Authorization
  * Request Forwarding.
  * Session & Cookie Management
* Traffic Oriented:
  * Rate Limit 
  * Traffic Split. By region, by IDC etc.
  * Circuit Breaker
* Business Oriented:
  * Business Security. Auti-fraud, for example
* System Oriented:
  * Security. CSRF
  * Observability.
    * Metrics
    * Tracing
    * Log

### MindMaps

```uml
@startmindmap

* Gateway

  **[#lightgreen] Request Oriented
		***[#lightgreen] Request Cleaning
			****[#lightgreen]: Validation
        For example, valiation based on rules;
			****[#lightgreen]: Normalisation 
        Normalize the request, for example, add necessary into to support metrics, tracing, or logs;
    ***[#lightgreen]: Authentication & Authorization
      Interated with different kinds of Authentication Services;
		***[#lightgreen] Request Forwarding
			****[#lightgreen]: Routing
        Routing rubles configurable;
			****[#lightgreen]: Request Conversion. For example
        http <-> internal protocol;
		***[#lightgreen] Session Management
		***[#lightgreen] Session Management 
		***[#lightgreen] Cookie Management 

	**[#lightblue] Traffic Oriented
 			***[#lightblue] Service Discovery
 			***[#lightblue] Rate Limit
 			***[#lightblue] Circuit Breaker
 			***[#lightblue]: Traffic Split 
      * For exmaple, Cross IDC for DR;
 			***[#lightblue] Load Balancing

	**[#orange] Business Oriented
	  ***[#orange] Auti Fraud
				****[#orange] Auti Crawler
				****[#orange] Others

	**[#lightGray] System Oriented
			***[#lightGray] Load Balancing
			***[#lightGray] Security
			  ****[#lightGray] Access Control
			  ****[#lightGray] CSRF
	  	***[#lightGray]: Observability
			* Monitoring & Alerts
			* Tracing
			* Log;
	  	***[#lightGray] Others
        
@endmindmap
```
