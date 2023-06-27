USE vk;

-- Предыдущую задачу решить с помощью процедуры 
-- и обернуть используемые команды в транзакцию внутри процедуры.

DROP PROCEDURE IF EXISTS delete_user_proc;

DELIMITER //

CREATE PROCEDURE delete_user_proc(IN who_del_id BIGINT)

BEGIN

	SET FOREIGN_KEY_CHECKS = 0;	

	START TRANSACTION;
    
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
        
	COMMIT;

END// 

DELIMITER ;

CALL delete_user_proc(3);









