with full_moon_reviews as (
    select * from {{ref("FULL_MOON_REVIEWS")}}
)
select 
    fr.is_full_moon,
    fr.review_sentiment,
    count(*) as review_count
from full_moon_reviews fr
group by fr.is_full_moon, fr.review_sentiment
order by fr.is_full_moon, fr.review_sentiment