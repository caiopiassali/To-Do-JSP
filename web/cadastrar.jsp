<%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 05/11/2018
  Time: 21:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cadastro : To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Main CSS -->
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="index.jsp">To-Do</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="index.jsp">Ínicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="cadastrar.jsp">Cadastrar</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="entrar.jsp">Entrar</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section style="padding-top: 100px;" class="mb-3">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 offset-sm-3">
                <div class="card">
                    <div class="card-body">
                        <form action="UsuarioCtr?action=doSignUp" method="post">
                            <div class="form-group text-center">
                                <span class="todo-title">To-Do</span>
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="text" name="nome" id="nome" placeholder="Nome" required>
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="email" name="email" id="email" placeholder="Email" required>
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="text" name="usuario" id="usuario" placeholder="Usuário" required>
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="password" name="senha" id="senha" minlength="6" placeholder="Senha" required>
                            </div>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="password" name="csenha" id="csenha" minlength="6" placeholder="Confirmar Senha" required>
                            </div>
                            <div class="has error d-none">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    Senhas Diferentes!
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                            <div class="form-group">
                                <input class="btn btn-success btn-block" type="submit" value="Cadastrar">
                            </div>
                            <div class="form-group text-center">
                                <a href="entrar.jsp">Já possui conta? Entre!</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Bootstrap core JavaScript -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

<script !src="">
    $("#csenha").on('blur', function () {
        if ($("input[name=senha]").val() != $("input[name=csenha]").val()) {
            $("div.has.error").removeClass("d-none");
        } else {
            $("div.has.error").addClass("d-none");
        }
    });
</script>
</body>
</html>
