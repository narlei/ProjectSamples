//
//	PSOwner.swift
//
//	Create by Narlei Moreira on 14/8/2017
//	Copyright © 2017 SocialBase. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper
import RealmSwift

class PSUser : Object, Mappable{

	var avatarUrl : String?
	var eventsUrl : String?
	var followersUrl : String?
	var followingUrl : String?
	var gistsUrl : String?
	var gravatarId : String?
	var htmlUrl : String?
	var id : Int?
	var login : String?
	var organizationsUrl : String?
	var receivedEventsUrl : String?
	var reposUrl : String?
	var siteAdmin : Bool?
	var starredUrl : String?
	var subscriptionsUrl : String?
	var type : String?
	var url : String?


    required convenience init?(map: Map) {
        self.init()
    }
    
	func mapping(map: Map)
	{
		avatarUrl <- map["avatar_url"]
		eventsUrl <- map["events_url"]
		followersUrl <- map["followers_url"]
		followingUrl <- map["following_url"]
		gistsUrl <- map["gists_url"]
		gravatarId <- map["gravatar_id"]
		htmlUrl <- map["html_url"]
		id <- map["id"]
		login <- map["login"]
		organizationsUrl <- map["organizations_url"]
		receivedEventsUrl <- map["received_events_url"]
		reposUrl <- map["repos_url"]
		siteAdmin <- map["site_admin"]
		starredUrl <- map["starred_url"]
		subscriptionsUrl <- map["subscriptions_url"]
		type <- map["type"]
		url <- map["url"]
		
	}
    
    override static func primaryKey() -> String? {
        return "login"
    }
}
