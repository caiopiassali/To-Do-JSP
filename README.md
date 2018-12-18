# To-Do-JSP

To-DO-JSP é um gerenciador de tarefas simples desenvolvido usando JSP.

## Pré-Requisitos

* [PostgreSQL](https://www.postgresql.org/)

## Instalação

1. Clone este repositório

2. Crie um banco PostgreSQL

3. Execute o script [`db.sql`](_files/db.sql)

4. Edite o arquivo [`ConnectionFactory.java`](src/br/com/todo/utils/ConnectionFactory.java) conforme suas configurações

```java
public static Connection getConnection() throws SQLException, Exception {
        try {
            Class.forName("org.postgresql.Driver");

            return DriverManager.getConnection("jdbc:postgresql://localhost:{PORTA_POSTGRES}/{NOME_DO_BANCO}","{USUARIO}","{SENHA}");
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        }
}
```

5. Execute o projeto

## Tencologias Usadas

* Java
* JSP
* SQL
* JS
* jQuery
* CSS
* Bootstrap

## Funcionalidades

- [x] Cadastro
- [x] Login
- [x] Logout
- [x] Criação de Sessão do usuário
- [x] Criação de Tarefas
- [x] Edição de Tarefas
- [x] Exclusão de Tarefas
- [x] Restauração de Tarefas
- [x] Filtro Tarefas por Estado
- [x] Gerenciamento de Estados
- [x] Criação de Estados personalizados
- [x] Lixeira
- [x] Exclusão e Restauração de múltiplas Tarefas
- [x] Mensagens de Confirmação

## Para Fazer

- [ ] Validar cadastro com emails repetidos
- [ ] Visualização e Edição de Perfil
- [ ] Buscar Tarefas por Nome
- [ ] Ajustes nas mensagens de erro
- [ ] Outros ajustes...
