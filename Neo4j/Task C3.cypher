Creating listing

create (l:Listing{listing_id:1001,
name:"Unique Cob Cottage",
summary:"Appearing in numerous books on natural building, our cottage is a welcoming and cozy retreat hand sculpted of local.",
listing_url:"https://www.airbnb.com.au/rooms/1720832",
picture_url:"https://www.airbnb.com.au/rooms/1720832?source_impression_id=p3_1571622270_LBlb2HzwCOWXQK%2BK",
host_id:9071324,
neighbourhood:"Vancouver",
street:"Mayne Island,BC,Canada",
zipcode:250,
latitude:48.6667,
longitude:-123.95,
room_type:"Entire home",
amenities:"{WiFi,Heating,Hot water,Iron,Refrigerator,BBQ grill,Smoke detector}",
price:177,
extra_people:50,
minimum_nights:2,
availability_365:150})

create (l:Listing{listing_id:1002,
name:"The World Famous Seashell House",
summary:"The world famous Seashell house is a gated property.",
listing_url:"https://www.airbnb.com.au/rooms/530250",
picture_url:"https://www.airbnb.com.au/rooms/530250?source_impression_id=p3_1571617870_4XNQY%2BwhIy4WEvoU",
host_id:481799,
neighbourhood:"La Gloria",
street:"Isla Mujeres,Mexico",
zipcode:77400,
latitude:21.2321696,
longitude:-86.7667381,
room_type:"Entire home",
amenities:"{WiFi,PayTV,Hot water,Iron,Refrigerator,Air conditioning,BBQ grill,Hair dryer,Smoke detector}",
price:441,
extra_people:80,
minimum_nights:3,
availability_365:100})

create (l:Listing{listing_id:1003,
name:"I SETTE CONI TRULLO EDERA",
summary:"Spend a unforgettable holiday in the enchanting surroundings of the town of Cisternino",
listing_url:"https://www.airbnb.com.au/rooms/432044",
picture_url:"https://www.airbnb.com.au/rooms/432044?source_impression_id=p3_1571617506_9Lq60kVX%2F7D7Igi%2B",
host_id:294274,
neighbourhood:"Campanile",
street:"Ostuni,BR,Italy",
zipcode:72017,
latitude:40.7268956,
longitude:17.562942,
room_type:"Entire home",
amenities:"{WiFi,Heating,Hot water,Cot,Refrigerator,Air conditioning,Kitchen,Smoke detector}",
price:114,
extra_people:20,
minimum_nights:1,
availability_365:180})


creating host

create(h:host{
host_id:9071324,
host_url:"https://www.airbnb.com.au/users/show/9071324",
host_name:"Alexis",
host_verifications:"['email', 'phone', 'facebook', 'government_id']",
host_since:2013-12-06,
host_location:"British Columbia,Canada",
host_response_time:"within a day",
host_is_superhost:true
})

create(h:host{
host_id:481799,
host_url:"https://www.airbnb.com.au/users/show/481799",
host_name:"Michelle",
host_verifications:['email', 'phone', 'government_id'],
host_since:2011-11-02,
host_location:"Cancun,Mexico",
host_response_time:"within an hour",
host_is_superhost:false
})

create(h:host{
host_id:294274,
host_url:"https://www.airbnb.com.au/users/show/294274",
host_name:"Anna",
host_verifications:['email', 'phone', 'reviews'],
host_since:2010-06-03,
host_location:"Ostuni, Italy",
host_response_time:"within an hour",
host_is_superhost:false
})


Creating reviews

create(r:review{
listing_id:1001,
id:575993,
date:2014-02-28,
reviewer_id:494947,
reviewer_name:"Hilary",
review_scores_rating:93,
comments:"Very hospitable, much appreciated."
})

create(r:review{
listing_id:1001,
id:755759,
date:2014-06-15,
reviewer_id:35355,
reviewer_name:"Melissa",
review_scores_rating:91,
comments:"This was my first time using airbnb and it was great."
})

create(r:review{
listing_id:1002,
id:35633,
date:2012-07-11,
reviewer_id:23456,
reviewer_name:"Michale",
review_scores_rating:94,
comments:"Breakfast was a pleasant bonus"
})

create(r:review{
listing_id:1002,
id:53536,
date:2015-11-19,
reviewer_id:54454,
reviewer_name:"Stuart",
review_scores_rating:90,
comments:"Spent some lovely time"
})

create(r:review{
listing_id:1002,
id:45535,
date:2013-03-21,
reviewer_id:65666,
reviewer_name:"Petra",
review_scores_rating:92,
comments:"Spent some lovely time"
})


relationships:

match(h:host{host_name:"Alexis"})
match(l:Listing{name:"Unique Cob Cottage"})
create (h)-[c1:creates]->(l)
return h,c1,l

match(h:host{host_name:"Michelle"})
match(l:Listing{name:"The World Famous Seashell House"})
create (h)-[c2:creates]->(l)
return h,c2,l

match(h:host{host_name:"Anna"})
match(l:Listing{name:"I SETTE CONI TRULLO EDERA"})
create (h)-[c3:creates]->(l)
return h,c3,l

------------------------------------

match(r:review{reviewer_name:"Hilary"})
match(l:Listing{name:"Unique Cob Cottage"})
create (r)-[re1:reviews]->(l)
return r,re1,l

match(r:review{reviewer_name:"Melissa"})
match(l:Listing{name:"Unique Cob Cottage"})
create (r)-[re2:reviews]->(l)
return r,re2,l

match(r:review{reviewer_name:"Michale"})
match(l:Listing{name:"The World Famous Seashell House"})
create (r)-[re3:reviews]->(l)
return r,re3,l

match(r:review{reviewer_name:"Stuart"})
match(l:Listing{name:"The World Famous Seashell House"})
create (r)-[re4:reviews]->(l)
return r,re4,l

match(r:review{reviewer_name:"Petra"})
match(l:Listing{name:"The World Famous Seashell House"})
create (r)-[re5:reviews]->(l)
return r,re5,l




2. match(h:host)
where toString(h.host_since)="2009"
set h.host_verifications="Facebook"
return h

3. match (h:host)
where h.host_response_time="within an hour"
set h.host_is_superhost=true
return h

4. match(r:review)
match(l:Listing)
match(h:host)
match(r)-[re:reviews]->(l)
where not toString(r.date)>"2017"
create (h:host{active:false})
return h

5. match(l:Listing{availability_365:0})
 where not (:review)-[:reviews]->(l:listing)
detach delete l