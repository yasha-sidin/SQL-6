USE vk;

-- * Написать триггер, который проверяет новое появляющееся сообщество. 
-- Длина названия сообщества (поле name) должна быть не менее 5 символов. 
-- Если требование не выполнено, то выбрасывать исключение с пояснением. 
DROP TRIGGER IF EXISTS check_new_community;

DELIMITER //

CREATE TRIGGER check_new_community BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
    IF NEW.name NOT LIKE '_____%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT Canceled. Name of community must consist not less than 5 characters.';
    END IF;
END//

DELIMITER ;
