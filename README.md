## Ellucian-Banner-Dart

### Just a little package providing some utilities to interface with Ellucian's Banner API.
--- 
This is primarily designed around the intent of managing a schedule, and as such provides an interface to a multitude of the endpoints that is provided by Ellucian Banner. It is outside of the scope of this package to try and provide any endpoints that may require authentication (to enable actions such as scripting enrollment) at this time.

Kudos to https://gitlab.com/jennydaman/nubanned#nu-banner-api which provided some (reverse engineered) documentation around the Ellucian Banner (EX/v9) api, which proved to be very useful in my conquest of making this package! 

In theory, this should work for any registration form site utilizing Ellucian's API, so long as the proper host is passed since all derivatives of the same API should follow the same URL paths and queries.

