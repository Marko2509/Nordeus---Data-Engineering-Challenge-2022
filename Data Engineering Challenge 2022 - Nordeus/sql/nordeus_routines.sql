-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nordeus
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'nordeus'
--
/*!50003 DROP PROCEDURE IF EXISTS `game_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `game_stats`()
begin
	with t1 as (
        select count(distinct(user_id)) as num_of_users_with_min_one_login, count(*) as num_of_logins
        from logins
    ), t2 as (
        select count(*) as num_of_transactions, coalesce(sum(transaction_amount_usd), 0) as total_revenue_usd
        from transactions
    )
    
    select t1.num_of_users_with_min_one_login, t1.num_of_logins, t2.num_of_transactions, t2.total_revenue_usd
    from t1, t2;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `game_stats_by_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `game_stats_by_country`(in country_input char(2))
begin
	with t1 as (
        select count(distinct(l.user_id)) as num_of_users_with_min_one_login, count(*) as num_of_logins
        from logins as l inner join registrations as r on l.user_id = r.user_id
        where r.country = country_input
    ), t2 as (
        select count(*) as num_of_transactions, coalesce(sum(transaction_amount_usd), 0) as total_revenue_usd
        from transactions as t inner join registrations as r on t.user_id = r.user_id
        where r.country = country_input
    )
    
    select t1.num_of_users_with_min_one_login, t1.num_of_logins, t2.num_of_transactions, t2.total_revenue_usd
    from t1, t2;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `game_stats_by_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `game_stats_by_date`(in date_search date)
begin
	with t1 as (
        select count(distinct(user_id)) as num_of_active_users, count(*) as num_of_logins
        from logins
        where date(event_timestamp) = date_search
    ), t2 as (
        select count(*) as num_of_transactions, coalesce(sum(transaction_amount_usd), 0) as total_revenue_usd
        from transactions
        where date(event_timestamp) = date_search
    )
    
    select t1.num_of_active_users, t1.num_of_logins, t2.num_of_transactions, t2.total_revenue_usd
    from t1, t2;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `game_stats_by_date_and_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `game_stats_by_date_and_country`(in date_search date, in country_input char(2))
begin
    with t1 as (
        select count(distinct(l.user_id)) as num_of_active_users, count(*) as num_of_logins
        from logins as l inner join registrations as r on l.user_id = r.user_id
        where r.country = country_input
        and date(l.event_timestamp) = date_search
    ), t2 as (
        select count(*) as num_of_transactions, coalesce(sum(transaction_amount_usd), 0) as total_revenue_usd
        from transactions as t inner join registrations as r on t.user_id = r.user_id
        where r.country = country_input
        and date(t.event_timestamp) = date_search
    )
    
    select t1.num_of_active_users, t1.num_of_logins, t2.num_of_transactions, t2.total_revenue_usd
    from t1, t2;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_stats`(in user_id_for_search char(36))
begin
	with t1 as (
		select country, name
		from registrations
		where user_id = user_id_for_search
	), t2 as (
		select count(*) as num_of_logins
		from logins
		where user_id = user_id_for_search
	), t3 as (
		select count(*) as num_of_transactions, coalesce(sum(transaction_amount_usd), 0) as total_revenue_usd
		from transactions
		where user_id = user_id_for_search
	), t4 as (
		select event_timestamp
		from logins
		where user_id = user_id_for_search
	), t5 as (
		select coalesce(datediff(max(x.event_timestamp), max(t4.event_timestamp)), 'Korisnik nema nijednu akciju logovanja') 
        as days_between_last_login_and_last_action_in_given_dataset
		from (
			select event_timestamp
			from logins
			union all 
			select event_timestamp
			from registrations
			union all 
			select event_timestamp
			from transactions
		) as x, t4
	)

	select 
		t1.country, 
		t1.name, 
		t2.num_of_logins,
		t3.num_of_transactions,
		t5.days_between_last_login_and_last_action_in_given_dataset,
		t3.total_revenue_usd
	from t1, t2, t3, t5;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_stats_by_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_stats_by_date`(in user_id_for_search char(36), in date_search date)
begin
	with t1 as (
		select country, name
		from registrations
		where user_id = user_id_for_search
	), t2 as (
		select count(*) as num_of_logins
		from logins
		where user_id = user_id_for_search
        and date(event_timestamp) = date_search
	), t3 as (
		select count(*) as num_of_transactions, coalesce(sum(transaction_amount_usd), 0) as total_revenue_usd
		from transactions
		where user_id = user_id_for_search
        and date(event_timestamp) = date_search
	), t4 as (
		select coalesce(abs(datediff(date_search, max(date(event_timestamp)))), 'Korisnik se nije logovao pre zadatog datuma')
        as days_between_last_login_before_input_date_and_input_date
        from logins
        where user_id = user_id_for_search
        and date(event_timestamp) <= date_search
	), t5 as (
		select coalesce(abs(datediff(max(date(event_timestamp)), date_search)), 'Korisnik se nema zabelezenu akciju logovanja')
        as days_between_input_date_and_last_login
        from logins
        where user_id = user_id_for_search
    )

	select 
		t1.country, 
		t1.name, 
		t2.num_of_logins,
		t3.num_of_transactions,
		t4.days_between_last_login_before_input_date_and_input_date,
        t5.days_between_input_date_and_last_login,
		t3.total_revenue_usd
	from t1, t2, t3, t4, t5;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-28 22:06:50
