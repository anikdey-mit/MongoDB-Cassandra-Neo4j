Import Data

C.1
LOAD CSV WITH HEADERS FROM "file:///host.csv"
AS row
WITH row WHERE row.host_id IS NOT NULL
MERGE (h:Host {host_id: row.host_id})
ON CREATE SET h.host_url = row.host_url,
h.host_name = row.host_name,
h.host_verifications = row.host_verifications,
h.host_since = row.host_since,
h.host_location = row.host_location,
h.host_response_time = row.host_response_time,
h.host_is_superhost = row.host_is_superhost


LOAD CSV WITH HEADERS FROM "file:///listing.csv"
AS row
WITH row WHERE row.id IS NOT NULL
MERGE (l:Listing {id: row.id})
ON CREATE SET l.name = row.name,
l.summary = row.summary,
l.listing_url = row.listing_url,
l.picture_url = row.picture_url,
l.host_id = row.host_id,
l.neighbourhood = row.neighbourhood,
l.street = row.street,
l.zipcode = row.zipcode,
l.latitude = row.latitude,
l.longitude = row.longitude,
l.room_type = row.room_type,
l.amenities = row.amenities,
l.price = row.price,
l.extra_people = row.extra_people,
l.minimum_nights = row.minimum_nights,
l.calculated_host_listings_count = row.calculated_host_listings_count,
l.availability_365 = row.availability_365



LOAD CSV WITH HEADERS FROM "file:///review.csv"
AS row
WITH row WHERE row.id IS NOT NULL
MERGE (r:Review {review_id: row.id})
ON CREATE SET
r.listing_id = row.listing_id,
r.reviewer_name = row.reviewer_name,
r.review_scores_rating = row.review_scores_rating,
r.reviewer_id = row.reviewer_id,
r.date=row.date

-----------------------------------------------------------




Create Relationships
From Host to Listing

LOAD CSV WITH HEADERS FROM "file:///host.csv" AS csvLine
MATCH (l:Listing {host_id: csvLine.host_id})
MATCH (h:Host {host_id: csvLine.host_id})
CREATE (h)-[c:CREATES]->(l)
return h,l,c

From Review to Listing
LOAD CSV WITH HEADERS FROM "file:///review.csv" AS csvLine
MATCH (l:Listing {id: csvLine.listing_id})
MATCH (r:Review {listing_id: csvLine.listing_id})
CREATE (r)-[b:REVIEWS]->(l)
return l,b,r

