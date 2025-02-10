
## **README**

# MovieBox - Gerenciamento de Filmes Favoritos

O **MovieBox** é uma aplicação web que permite aos usuários gerenciar uma lista de filmes favoritos, utilizando a API OMDb para buscar informações sobre os filmes e armazenando esses dados no banco de dados MongoDB. A aplicação oferece funcionalidades completas de CRUD (Create, Read, Update, Delete) para o gerenciamento dos filmes favoritos.

https://github.com/user-attachments/assets/ab0d58ab-64ce-427a-97af-6baaedf06927

### Funcionalidades
- **Adicionar Filmes aos Favoritos**: Buscar filmes pela API OMDb e adicionar aos favoritos.
- **Visualizar Detalhes**: Exibir título, ano, gênero, diretor, sinopse e comentários do usuário.
- **Atualizar Comentário**: Permitir que o usuário adicione ou edite comentários sobre o filme.
- **Remover Filmes**: Excluir filmes da lista de favoritos.

### **Tecnologias Utilizadas**
- **Back-end**: Ruby on Rails
- **Banco de Dados**: MongoDB (com Mongoid como ORM)
- **Front-end**: HTML5, CSS, Bootstrap
- **API Externa**: OMDb API
- **Containerização**: Docker

---

### **Pré-requisitos**

Antes de rodar a aplicação, você precisa ter os seguintes softwares instalados:

- **Ruby** (versão 2.7.2 ou superior)
- **Rails** (versão 7.1.5 ou superior)
- **Docker** (para containerizar a aplicação)
- **Git** (para controle de versão)

---

### **Passo a Passo para Rodar a Aplicação**

#### **1. Clone o Repositório**
Primeiro, clone o repositório para a sua máquina local:

```bash
git clone https://github.com/leorchrds/moviebox.git
cd moviebox
```

#### **2. Configure a Chave da API OMDb**
Para utilizar a API OMDb, você precisa configurar a sua chave de API. Siga os passos abaixo:

1. Crie uma conta na [OMDb API](https://www.omdbapi.com/apikey.aspx) e obtenha a sua chave de API.
2. No arquivo `.env` ou em seu ambiente de desenvolvimento, adicione a chave da API como uma variável de ambiente. Exemplo:

   ```bash
   OMDB_API_KEY=SuaChaveAqui
   ```

Isso garante que a aplicação possa fazer requisições à API para buscar informações sobre os filmes.

#### **3. Rodar a Aplicação com Docker (Recomendado)**

Se você deseja rodar a aplicação em containers Docker, basta usar o `docker-compose`. Ele irá configurar automaticamente o ambiente, incluindo o banco de dados MongoDB e o servidor Rails.

Para iniciar os containers, execute o seguinte comando:

```bash
docker-compose up --build
```

Este comando irá:
- Construir a imagem do projeto
- Subir os containers para o MongoDB e a aplicação Rails

O Docker irá garantir que a aplicação e o banco de dados estejam configurados corretamente, sem a necessidade de instalação manual do MongoDB.

#### **4. Acessar a Aplicação**

Após rodar o `docker-compose`, a aplicação estará disponível em `http://localhost:3000`.

#### **5. Rodar a Aplicação Localmente (Alternativa)**

Se você preferir rodar a aplicação localmente sem usar Docker, siga os seguintes passos:

1. **Instale as dependências**:

   ```bash
   bundle install
   ```

2. **Configure o Banco de Dados** (se não estiver usando Docker):

   Certifique-se de ter o MongoDB rodando em sua máquina. Se for usar o MongoDB localmente, você pode iniciar o servidor com:

   ```bash
   mongod
   ```

3. **Inicie a Aplicação**:

   Com o MongoDB configurado, inicie o servidor Rails com o comando:

   ```bash
   rails server
   ```

A aplicação estará disponível em `http://localhost:3000`.

