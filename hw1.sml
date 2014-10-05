fun is_older (day1 : int*int*int, day2 : int*int*int) =
    (#1 day1 < #1 day2) 
    orelse (#1 day1 = #1 day2 andalso #2 day1 < #2 day2)
    orelse (#1 day1 = #1 day2 andalso #2 day1 = #2 day2 andalso #3 day1 < #3day2)

fun number_in_month (dates : (int*int*int) list, month : int) = 
    if null dates
    then 0
    else
	if #2(hd dates) = month
	then 1+number_in_month(tl dates, month)
	else number_in_month(tl dates, month)

fun number_in_months(dates:(int*int*int) list, months : int list) =
    if null months
    then 0
    else number_in_month(dates, hd months)+number_in_months(dates,tl months)

fun dates_in_month(dates:(int*int*int) list, month :int) = 
    if null dates
    then []
    else
	if #2(hd dates) = month
	then (hd dates)::dates_in_month(tl dates, month)
	else dates_in_month(tl dates, month)

fun dates_in_months(dates:(int*int*int) list, months :int list) =
    if null months
    then []
    else dates_in_month(dates, hd months)@dates_in_months(dates,tl months)

fun get_nth(strings: string list, n :int)=
    if n=1
    then hd strings
    else get_nth(tl strings, n-1)

fun date_to_string(date:int*int*int)=
    get_nth(["January","February","March","April","May","June","July","August","September","October","Noverber","Decenber"],(#2 date))^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)

fun number_before_reaching_sum(sum:int, num:int list)=
    if hd num >= sum
    then 0
    else 1+number_before_reaching_sum(sum-(hd num), tl num)

fun what_month(day:int)=
    1+number_before_reaching_sum(day,[31,28,31,30,31,30,31,31,30,31,30,31])

fun month_range(day1:int, day2:int)=
    if day1>day2
    then []
    else what_month(day1)::month_range(day1+1,day2)

fun oldest(dates: (int*int*int) list)=
    if null dates
    then NONE
    else
	let val tl_oldest = oldest(tl dates)
	in if isSome tl_oldest andalso is_older((valOf tl_oldest), hd dates)
	   then tl_oldest
	   else SOME(hd dates)
	end
