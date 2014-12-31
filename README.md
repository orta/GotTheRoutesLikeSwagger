You've got the routes like Swagger.
======================

Ruby app to take a Swagger API and generate NSURLRequests.
Currently very rough, but you can see the names for functions in the NSURLRequest Router.

``` sh
# usage
ruby routes-like.rb [swagger url] [authentication token]
```

```
swagger-grabber · (master) ⟩ ruby routes-like.rb
getAccessControls
removeAccessToken
getAdmins
getAdminsAvailableRepresentatives
getAdminsRepresentatives
updateAdminWithID:(NSString *)slug
getAnalyticsEmails
getAnalyticsEmailsWithID:(NSString *)slug
updateAnalyticsEmailsWithID:(NSString *)slug
createAnalyticsEmailsSendWithID:(NSString *)slug
getArtistFollowUsersWithID:(NSString *)slug
getArtistArtworkInquiryRequestsWithID:(NSString *)slug
getArtistWithID:(NSString *)slug
updateArtistWithID:(NSString *)slug
removeArtistWithID:(NSString *)slug
createArtist
```