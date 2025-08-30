{% snapshot scd_raw_listings %}

{{
    config(
            target_schema = 'raw_dev',
            unique_key = 'id',
            strategy = 'timestamp',
            updated_at = 'updated_at',
            invalidate_hard_deletes=True
    )
}}

select * from {{source('airbnb_raw_data', 'RAW_LISTINGS')}}

{% endsnapshot %}