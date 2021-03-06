xquery version "3.0"  encoding "UTF-8";
(:~
 : This module offers helper functions for the controllers
 :)
 
module namespace ch = "memory/src/controller/controllerHelper";

import module namespace request = "http://exquery.org/ns/request";
 
(:~
 :
 :)
declare 
    function ch:callModelFunction($method as xs:string, $path as xs:string, $body as item()?) 
{   
    let $request := 
        <http:request method="{$method}">
            <http:body media-type="application/xml"/>
        </http:request>
    let $uri := ch:buildURI($path)
    return http:send-request($request, $uri, $body)
};

declare 
    function ch:buildHTML($head, $body) 
{
    <html>
        {$head}
        {$body}
    </html>
};

declare
    function ch:buildURI($path as xs:string)
{
    request:scheme() || "://" || request:hostname() || ":" || request:port() || $path
};

declare
    function ch:db_gameIdExists($id as xs:string) as xs:boolean
{
    let $path := "/model/database/gameIdExists/" || $id
    return xs:boolean(ch:callModelFunction("get", $path, ())[2]/boolean)
};

