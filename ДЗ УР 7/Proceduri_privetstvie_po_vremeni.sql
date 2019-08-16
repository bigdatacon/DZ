DELIMITER //

DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now()
BEGIN
	IF ( DATE_FORMAT(now(), "%H:%i:%s") < '12.00.00' ) THEN
		SELECT 'доброе утро' as PRIVETSTVIE; 
	elseif ( '12.00.00' <= DATE_FORMAT(now(), "%H:%i:%s") < '16.00.00' ) THEN
		SELECT 'добрый день' as PRIVETSTVIE; 
	else
		select 'доброе вечер' as PRIVETSTVIE; 
	END IF ;
END //
CALL format_now()//