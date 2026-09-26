{%- set fruits=["Orange","Apple","Mango","Grapes","Banana"] -%}
{%for i in fruits%}
    {%if i!="Grapes"%}
        {{i}}
    {%else%}
        I hate {{i}} 
    {%endif%}
{%endfor%}