# Delivery

![img](https://elixir-lang.org/images/logo/logo.png)



Delivery is an elixir's API where you create users, items and orders. It also runs a scheduled job to generate the orders' report. 

## Run Locally

Clone the project

```bash
  git clone git@github.com:leoDPNunes/Delivery.git
```

Go to the project directory

```bash
  cd delivery
```

Install dependencies

```bash
  mix deps.gets
```

Create and migrate your database with 

```bash
  mix ecto.setup
```

or execute the commands

  - creates the database
```bash
  mix ecto.create
```
  - run the migrations
```bash
  mix ecto.migrate
```

Start the server

```bash
  mix phx.server
```
  
## API Reference (local / deploy)

```http
deploy
  "baseURL": "https://radiant-leafy-sapsucker.gigalixirapp.com/"
```
```http
local
  "baseURL": "http://localhost:4000/"
```

#### Create an User

```http
  POST /api/users
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `age` | `integer` | **Required**. at least 18 or over |
| `address` | `string` | **Required**.|
| `zipcode` | `string` | **Required**. size: 8 |
| `cpf` | `string` | **Required**. size: 11, unique |
| `email` | `string` | **Required**. unique |
| `password` | `string` | **Required**. min: 6|
| `name` | `string` | **Required**.|

#### Get an User

```http
  GET /api/users/:id
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. UUID, route params |
| `token` | `string` | **Required**. bearer token |

#### Update an User

```http
  PUT /api/users/:id
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `age` | `integer` | **Required**. at least 18 or over |
| `address` | `string` | **Required**.|
| `zipcode` | `string` | **Required**. size: 8 |
| `cpf` | `string` | **Required**. size: 11, unique |
| `email` | `string` | **Required**. unique |
| `password` | `string` | **Required**. min: 6|
| `name` | `string` | **Required**. |
| `id` | `string` | **Required**. UUID, route params |
| `token` | `string` | **Required**. bearer token |

#### Delete an User

```http
  DEL /api/users/:id
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. UUID, route params |
| `token` | `string` | **Required**. bearer token |

#### User Login 

```http
  POST /users/signin
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. UUID |
| `password` | `string` | **Required**. min: 6|


#### Create an Item

```http
  POST /api/items
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `category` | `enum` | **Required**. [:food, :drink, :dessert] |
| `description` | `string` | **Required**. min: 6|
| `price` | `decimal` | **Required**. at least zero (gift/sale) or over |
| `photo` | `string` | **Required**. |
| `token` | `string` | **Required**. bearer token |

#### Create an Order

```http
  POST /api/orders
```
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `user_id` | `string` | **Required**. UUID |
|  |  | |
| `list o f items` | `string` | **Required**.  |
| `item_id` | `string` | **Required**. UUID, part of the list of items|
| `quantity` | `integer` | **Required**. part of the list of items |
|  |  | |
| `address` | `string` | **Required**. min: 10|
| `comments` | `string` | **Required**. min: 6|
| `payment_method` | `enum` | **Required**. [:money, :credit_card, :debit_card] |
| `token` | `string` | **Required**. bearer token |

<img src="/asset/orders.png" alt="Insomnia Create Orders Example"/>

#### CRUD of User GRAPHQL

```http
deploy
  GET /graphql/api/users
```

```http
local
  GET /graphiql/api/users
```


I'm starting to learn how to implement the graphql in elixir.
The user crud implementation is similar to the rest
implementation but it wasn't created the authentication yet, so
you don't need a token for now. Furthermore, it wasn't created the
login yet.


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


  
## License

[MIT](https://choosealicense.com/licenses/mit/)

