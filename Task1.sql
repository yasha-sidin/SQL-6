USE vk;

-- Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. 
-- Пользователь задается по id. 
-- Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users. 
-- Функция должна возвращать номер пользователя.

DROP FUNCTION IF EXISTS delete_user_func;

DELIMITER //

CREATE FUNCTION delete_user_func(who_will_be_deleted_id BIGINT)
RETURNS BIGINT DETERMINISTIC

BEGIN

	DECLARE who_del_id BIGINT;
    SET FOREIGN_KEY_CHECKS = 0;
	SET who_del_id = who_will_be_deleted_id;

	DELETE FROM Messages
	WHERE from_user_id = who_del_id OR to_user_id = who_del_id;

	DELETE FROM likes
	WHERE user_id = who_del_id OR media_id IN (SELECT id FROM media WHERE user_id = who_del_id);

	DELETE FROM media
	WHERE user_id = who_del_id;

	DELETE FROM profiles
	WHERE user_id = who_del_id;

	DELETE FROM users
	WHERE id = who_del_id;

    SET FOREIGN_KEY_CHECKS = 1;	
    
	RETURN who_del_id;

END// 

DELIMITER ;

SELECT delete_user_func(1);









