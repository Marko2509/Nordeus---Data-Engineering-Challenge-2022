const mysql = require('mysql');

const express = require('express');
var app = express();
const bodyparser = require('body-parser');
const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");

app.use(bodyparser.json());

var mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'nordeus',
    multipleStatements: true
});

mysqlConnection.connect((err) => {
    if (!err) {
        console.log('DB connection succeded.');
    }
    else {
        console.log('***DB connection failed \n Error : ' + JSON.stringify(err, undefined, 2));
    }
});

app.listen(3000, () => console.log('Express server is running at port 3000'));

const swaggerOptions = {
	definition: {
		openapi: "3.0.0",
		info: {
			title: "REST API",
			version: "1.0.0",
			description: "REST API for Data Engineering Challenge 2022 - Nordeus",
		},
		servers: [
			{
				url: "http://localhost:3000",
			},
		],
	},
	apis: ["index.js"],
};

const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs));


 /**
  * @swagger
  * tags:
  *   name: [User, Game]
  */

 /**
 * @swagger
 * components:
 *   schemas:
 *      UserStats:
 *         type: object
 *         required:
 *           - country
 *           - name
 *           - num_of_logins
 *           - num_of_transactions
 *           - days_between_last_login_and_last_action_in_given_dataset
 *           - total_revenue_usd
 *         properties:
 *           country:
 *             type: string
 *             description: Two character country code of the user
 *           name:
 *             type: string
 *             description: Name of the user
 *           num_of_logins:
 *             type: integer
 *             description: Number of user logins
 *           num_of_transactions:
 *             type: integer
 *             description: Number of user transactions
 *           days_between_last_login_and_last_action_in_given_dataset:
 *             type: string
 *             description: How many days have between the last user login and the last date that the given dataset has data for (last action by any user)
 *           total_revenue_usd:
 *             type: decimal
 *             description: Revenue represents the sum of all transactions that the user made
 *         example:
 *          country: US
 *          name: Joshua Kelley
 *          num_of_logins: 2
 *          num_of_transactions: 1
 *          days_between_last_login_and_last_action_in_given_dataset: "1"
 *          total_revenue_usd: 0.99
 */

 /**
 * @swagger
 * components:
 *   schemas:
 *     UserStats2:
 *       type: object
 *       required:
 *         - country
 *         - name
 *         - num_of_logins
 *         - num_of_transactions
 *         - days_between_last_login_before_input_date_and_input_date
 *         - days_between_input_date_and_last_login
 *         - total_revenue_usd
 *       properties:
 *         country:
 *           type: string
 *           description: Two character country code of the user
 *         name:
 *           type: string
 *           description: Name of the user
 *         num_of_logins:
 *           type: integer
 *           description: Number of user logins
 *         num_of_transactions:
 *           type: integer
 *           description: Number of user transactions
 *         days_between_last_login_before_input_date_and_input_date:
 *           type: integer
 *           description: How many days have between the last user login before input date and the input date
 *         days_between_input_date_and_last_login:
 *            type: integer
 *            description: How many days have between the input date and last login action by user
 *         total_revenue_usd:
 *           type: decimal
 *           description: Revenue represents the sum of all transactions that the user made
 *       example:
 *         country: US
 *         name: Shannon Diaz
 *         num_of_logins: 1
 *         num_of_transactions: 1
 *         days_between_last_login_before_input_date_and_input_date: 0
 *         days_between_input_date_and_last_login: 1
 *         total_revenue_usd: 0.99
 */


/**
 * @swagger
 * components:
 *   schemas:
 *      GameStats:
 *         type: object
 *         required:
 *           - num_of_users_with_min_one_login
 *           - num_of_logins
 *           - num_of_transactions
 *           - total_revenue_usd
 *         properties:
 *           num_of_users_with_min_one_login:
 *             type: integer
 *             description: Number of all users that had at least one login action
 *           num_of_logins:
 *             type: integer
 *             description: Total number of logins
 *           num_of_transactions:
 *             type: integer
 *             description: Total number of transactions
 *           total_revenue_usd:
 *             type: decimal
 *             description: Total revenue in USD
 *         example:
 *           num_of_users_with_min_one_login: 5920
 *           num_of_logins: 17892
 *           num_of_transactions: 569
 *           total_revenue_usd: 1243.919
 */

/**
 * @swagger
 * components:
 *   schemas:
 *      GameStats2:
 *         type: object
 *         required:
 *           - num_of_active_users
 *           - num_of_logins
 *           - num_of_transactions
 *           - total_revenue_usd
 *         properties:
 *           num_of_active_users:
 *             type: integer
 *             description: Number of daily active users - if a user has had a login that day, he is considered a daily active user
 *           num_of_logins:
 *             type: integer
 *             description: Number of logins
 *           num_of_transactions:
 *             type: integer
 *             description: Number of transactions
 *           total_revenue_usd:
 *             type: decimal
 *             description: Revenue in USD
 *         example:
 *           num_of_active_users: 216
 *           num_of_logins: 344
 *           num_of_transactions: 11
 *           total_revenue_usd: 49.969
 */

/**
 * @swagger
 * /user/{user_id}:
 *  get:
 *    summary: Returns the user level stats for user with input user_id
 *    tags: [User]
 *    parameters:
 *      - in: path
 *        name: user_id
 *        schema:
 *          type: string
 *        required: true
 *        description: User id for finding user stats (36 characters - case insensitive)
 *    responses:
 *      200:
 *        description: User stats
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/UserStats'
 *      400:
 *        description: The user_id is not valid length (it's over 36 characters)
 *      404:
 *        description: There is no user with that user_id
 */
app.get('/user/:user_id', (req, res) => {

    query = `call user_stats(?);`

    mysqlConnection.query(query, [req.params.user_id],  (err, rows) => {
        if(err) {
            res.status(400).send(err.sqlMessage);
            return;
        }
    
        const resultJson = rows[0];
    
        if(resultJson.length === 0) {
            res.status(404).send("Ne postoje podaci za unete parametre");
            return;
        }
    
        res.send(rows[0][0]);
    })
});

/**
 * @swagger
 * /user/{user_id}/{date}:
 *  get:
 *    summary: Returns the user level stats for user with input user_id on certain date
 *    tags: [User]
 *    parameters:
 *      - in: path
 *        name: user_id
 *        schema:
 *          type: string
 *        required: true
 *        description: User id for finding user stats (36 characters - case insensitive)
 *      - in: path
 *        name: date
 *        schema:
 *          type: string
 *        required: true
 *        description: Date for filtering user stats (format YYYY-MM-DD)
 *    responses:
 *      200:
 *        description: User stats
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/UserStats2'
 *      400:
 *        description: The user_id is not valid length (it's over 36 characters) or/and the date is in bad format or invalid
 *      404:
 *        description: There is no user with that user_id
 */
app.get('/user/:user_id/:date', (req, res) => {

    query = `call user_stats_by_date(?, ?)`

    mysqlConnection.query(query, [req.params.user_id, req.params.date],  (err, rows) => {
        if(err) {
            res.status(400).send(err.sqlMessage);
            return;
        }
    
        const resultJson = rows[0];
    
        if(resultJson.length === 0) {
            res.status(404).send("Ne postoje podaci za unete parametre");
            return;
        }
    
        res.send(rows[0][0]);
    })
});

/**
 * @swagger
 * /game:
 *   get:
 *     summary: Returns the game level stats
 *     tags: [Game]
 *     responses:
 *       200:
 *         description: All time stats for the game
 *         content:
 *           application/json:
 *              schema:
 *                $ref: '#/components/schemas/GameStats'
 *       500:
 *         description: Unexpected error
 */
app.get('/game', (req, res) => {

    query = `call game_stats;`

    mysqlConnection.query(query, (err, rows) => {
        if(err) {
            res.status(500).send(err.sqlMessage);
            return;
        }
    
        res.send(rows[0][0]); 
    })
});

/**
 * @swagger
 * /game/date/{date}:
 *  get:
 *    summary: Returns the game level stats for certain date
 *    tags: [Game]
 *    parameters:
 *      - in: path
 *        name: date
 *        schema:
 *          type: string
 *        required: true
 *        description: Date for filtering game level stats (format YYYY-MM-DD)
 *    responses:
 *      200:
 *        description: Game stats for input date
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/GameStats2'
 *      400:
 *        description: The date is in bad format or invalid
 */
app.get('/game/date/:date', (req, res) => {

    query = 
    `call game_stats_by_date(?);`

    mysqlConnection.query(query, [req.params.date],  (err, rows) => {
        if(err) {
            res.status(400).send(err.sqlMessage);
            return;
        }
    
        res.send(rows[0][0]); 
    })
});

/**
 * @swagger
 * /game/country/{country}:
 *  get:
 *    summary: Returns the game level stats for certain country
 *    tags: [Game]
 *    parameters:
 *      - in: path
 *        name: country
 *        schema:
 *          type: string
 *        required: true
 *        description: Two character country code for filtering game level stats (format XX - case insensitive)
 *    responses:
 *      200:
 *        description: Game stats for input country
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/GameStats'
 *      400:
 *        description: The country is in bad format
 */
app.get('/game/country/:country', (req, res) => {
    query = 
    `call game_stats_by_country(?);`

    mysqlConnection.query(query, [req.params.country],  (err, rows) => {
        if(err) {
            res.status(400).send(err.sqlMessage);
            return;
        }
    
        res.send(rows[0][0]); 
    })
});

/**
 * @swagger
 * /game/{date}/{country}:
 *  get:
 *    summary: Returns the game level stats for certain date and country
 *    tags: [Game]
 *    parameters:
 *      - in: path
 *        name: date
 *        schema:
 *          type: string
 *        required: true
 *        description: Date for filtering game level stats (format YYYY-MM-DD)
 *      - in: path
 *        name: country
 *        schema:
 *          type: string
 *        required: true
 *        description: Two character country code for filtering game level stats (format XX - case insensitive)
 *    responses:
 *      200:
 *        description: Game stats for input date and country
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/GameStats2'
 *      400:
 *        description: The date is in bad format or invalid or/and the country is in bad format
 */
app.get('/game/:date/:country', (req, res) => {
    query = 
    `call game_stats_by_date_and_country(?, ?);`

    mysqlConnection.query(query, [req.params.date, req.params.country],  (err, rows) => {
        if(err) {
            res.status(400).send(err.sqlMessage);
            return;
        }
    
        res.send(rows[0][0]); 
    })
});