xquery version "3.0"  encoding "UTF-8";

(:~
 : This module offers helper functions for the controllers
 :)
 
module namespace ch = 'memory/src/controller/controllerHelper';

import module namespace request = "http://exquery.org/ns/request";
 
(:~
 :
 :)
declare 
    function ch:callModelFunction($method as xs:string, $path as xs:string, $body as item()?) 
{   
    let $uri := ch:buildURI($path)
    return http:send-request(
        <http:request method="{$method}"/>,
        $uri, $body
    )
};

declare 
    function ch:buildHTML($head, $body) 
{
    <html xmlns="http://www.w3.org/1999/xhtml">
        {$head}
        {$body}
    </html>
};

declare %private 
    function ch:buildURI($path as xs:string)
{
    request:scheme() || "://" || request:hostname() || ":" || request:port() || $path
};