{% macro learn_variables()%}
    {% set your_name = 'Mohamed Eldeeb'%}
    {{log('hello ' ~ your_name, info = True)}}
    {{log('hello dbt user ' ~ var('user_name','No User Name were set'), info = True)}}
{% endmacro %}
