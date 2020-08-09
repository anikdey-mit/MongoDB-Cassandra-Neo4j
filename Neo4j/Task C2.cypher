1. match(l:Listing{name:'Sunny 1950s Apartment, St Kilda East Longer stays'})
return count(*)

2. match(l:Listing{neighbourhood:"Port Phillip"})--(r:Review)
 return l,r

 
3. match(r:Reviewer{reviewer_id:"317848)"})-[:REVIEWS]->(l:Listing)
where r.review_scores_rating > 90
and not exists ((r:Reviewer{reviewer_id:"4162110"})-[:REVIEWS]->(l:Listing))
return r,l

4. Match (l:Listing)
where not l.amenities Contains "Wifi"
return l.name,l.street

5. match(r:Review)-[re:REVIEWS]->(l:Listing)
return count(re)
 

7. match (l:Listing)
where not(:Review)-[:REVIEWS]->(l:Listing)
return l


8. match(a:Host)-[:CREATES]->(b:Listing)
with a.host_name as hname,collect(b)as bb,size(collect((a)-[:CREATES]->(b)))as lc
where lc>1
unwind bb as x
return hname,x.name,x.price
 
9. match(l:Listing{neighbourhood:"Melbourne"})
 return avg(toInt(l.price))
 
10. match(h:Host)-[:CREATES]->(l:Listing)
return toINT(l.price),l.street,h
order by toINT(l.price) desc
limit 5

11. match(a:Review)-[:REVIEWS]->(b:Listing)
where substring(a.date,0,4)="2017"
return count(b.name)

12. match(r:Review)-[:REVIEWS]->(l:Listing)
return avg(toInt(r.review_scores_rating)), l.neighbourhood
order by avg(toInt(r.review_scores_rating)) desc
limit 10

13. match(h:Host)-[:CREATES]->(l:Listing)
where h.host_location <> l.street
return h.host_name,h.host_location,l.name,l.street

14. match(l:Listing)
with (toString(l.extra_people)*2)*5 as people,(toString(l.price)*2)*5 as tprice,l.name as name,l.street as address,l.price as price_per_night,l.extra_people as extra_price
return name,address,price_per_night,extra_price,tprice
order by tprice


-----------------------
Additional 5 queries

1. List top 10 neighbourhoods according to number of reviews.

match(r:Review)-[:REVIEWS]->(l:Listing)
return count(r),l.neighbourhood
order by count(r) desc
limit 10

2. List top 10 host name who got highest number of reviews.

match(r:Review)-[:REVIEWS]->(l:Listing)
match(h:Host)-[:CREATES]->(l:Listing)
return count(r),h.host_name
order by count(r) desc
limit 10

3. List top 10 reviewer name accoding to the number of reviews they provided.

match(r:Review)-[:REVIEWS]->(l:Listing)
with r.reviewer_name as rname,collect(l)as ll,size(collect((r)-[:REVIEWS]->(l))) as lc
return rname, lc
order by lc desc
limit 10

4. List the listings which have availability between 300 and 200. And create a descending order.

match (l:Listing)
where toINT(l.availability_365)>200 and toINT(l.availability_365)<300
return l.name,l.street,toINT(l.availability_365)
order by toINT(l.availability_365) desc

5. How many private rooms in the listing?

match(l:Listing)
where l.room_type="Private room"
return count(l.room_type)

-------------------------------------------------

Index:

1. Index on neighbourhoods.
create index on:Listing(neighbourhood);

2. Index on price and amenities.
create index on:Listing(price,amenities);

3. Index on review date, reviewer name and ratings.
create index on:revie(date,reviewer_name,review_scores_rating);