<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 08/11/2018
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cadastrar Tarefa: To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Main CSS -->
    <link rel="stylesheet" href="../css/main.css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="/" title="Dashboard">To-Do</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger active" href="/TarefaCtr?action=listTasks" title="Dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=lixeira" title="Lixeira">Lixeira</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/EstadoCtr?action=listStatus" title="Estados">Estados</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/UsuarioCtr?action=doLogout" title="Sair">Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section style="padding-top: 80px">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 offset-3">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center">Cadastrar Tarefa</h3>
                        <form action="/TarefaCtr?action=createTask" method="post">
                            <div class="form-group">
                                <input tabindex="1" class="form-control form-control-lg" type="text" name="titulo" id="titulo" placeholder="Título">
                            </div>
                            <div class="form-group">
                                <textarea tabindex="2" class="form-control" cols="30" rows="5" name="texto" id="texto" placeholder="Descrição"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="estado">Estado</label>
                                <div class="row">
                                    <div class="col-sm-10">
                                        <select tabindex="3" class="form-control" name="estado" id="estado">
                                            <c:forEach var="estado" items="${estados}">
                                                <option value="${estado.codigo}">
                                                        ${estado.titulo}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">
                                        <button tabindex="4" type="button" data-toggle="modal" data-target="#cadastrarEstado" class="btn btn-info btn-block">+</button>
                                    </div>
                                </div>
                            </div>
                            <% if (request.getAttribute("erro") != null) { %>
                            <div class="form-group">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <%=request.getAttribute("erro")%>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-6">
                                        <input tabindex="5" class="btn btn-success btn-block" type="submit" value="Cadastrar">
                                    </div>
                                    <div class="col-6">
                                        <input tabindex="6" class="btn btn-secondary btn-block" type="reset" value="Cancelar">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modal -->
<div class="modal fade" id="cadastrarEstado" tabindex="-1" role="dialog">
    <form name="createStatus" action="/EstadoCtr?action=createAjaxStatus" method="post">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cadastrar Estado</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" method="post">
                        <div class="form-group">
                            <input class="form-control form-control-lg" type="text" name="titulo" id="etitulo" placeholder="Estado" required>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-6">
                                    <input type="submit" class="btn btn-success btn-block" value="Cadastrar">
                                </div>
                                <div class="col-6">
                                    <input class="btn btn-secondary btn-block"data-dismiss="modal" value="Cancelar">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- Bootstrap core JavaScript -->
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

<script !src="">
    $("form[name=createStatus]").on('submit', function (e) {
        e.preventDefault();
        var form = $(this);
        $.ajax({
            url: '/EstadoCtr?action=createAjaxStatus',
            type: "POST",
            data: "titulo=" + form.find("input[name=titulo]").val(),
            dataType: "text"
        }).done(function(resposta) {
            if (resposta != "false") {
                var json = JSON.parse(resposta);
                $("select[name=estado]").append(new Option(json.titulo, json.codigo, false, true));
                $("#cadastrarEstado").modal("toggle");
            }
        }).fail(function(jqXHR, textStatus ) {
            console.log(textStatus);
        });
    });

    $("form").on('reset', function (e) {
       e.preventDefault();
       history.back();
    });
</script>

</body>
</html>
