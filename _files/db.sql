/** DB **/
/*databasename = todo */

/** Tables **/
CREATE TABLE estado (
  id_estado SERIAL NOT NULL
    CONSTRAINT pk_estado
      PRIMARY KEY,
  titulo_estado VARCHAR(30) NOT NULL
);

CREATE TABLE usuario (
  id_usuario SERIAL NOT NULL
    CONSTRAINT pk_usuario
      PRIMARY KEY,
  nome_usuario VARCHAR(100) NOT NULL,
  email_usuario VARCHAR(100) NOT NULL,
  login_usuario VARCHAR(50) NOT NULL,
  senha_usuario VARCHAR(50) NOT NULL
);

CREATE TABLE tarefa (
  id_tarefa SERIAL NOT NULL
    CONSTRAINT pk_tarefa
      PRIMARY KEY,
  titulo_tarefa VARCHAR(50) NOT NULL,
  texto_tarefa TEXT NOT NULL,
  data_criacao_tarefa DATE DEFAULT NOW(),
  codigo_estado INTEGER NOT NULL
    CONSTRAINT fk_estado_tarefa
      REFERENCES estado,
  codigo_usuario INTEGER NOT NULL
    CONSTRAINT fk_usuario_tarefa
      REFERENCES usuario,
  lixeira BOOLEAN NOT NULL DEFAULT FALSE
);

/** Inserts **/
INSERT INTO estado (titulo_estado) VALUES ('Para Fazer');
INSERT INTO estado (titulo_estado) VALUES ('Fazendo');
INSERT INTO estado (titulo_estado) VALUES ('Concluído');
INSERT INTO estado (titulo_estado) VALUES ('Aguardando');