-- limit
-- limit elect 문의 경로가 집합에서 반환할 행의 수를 제한하는데 사용된다.

select
	*
from
	tbl_menu
order by
	menu_price desc;
    
select
	*
from tbl_menu
order by
	menu_price desc
limit 5;

-- limit [offset, ] row)_count
-- offset : 시작할 행의 번호(인덱스 체계)
-- row_count : 이후 행 부터 빈환 받을 행의 갯수

select
	menu_code,
    menu_name,
    menu_price
from
	tbl_menu
order by
	menu_price desc
limit 0,4; -- 인덱스 체계  인덱스 부터, 몇개 까지