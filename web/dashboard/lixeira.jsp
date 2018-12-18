<%@ page import="br.com.todo.model.Tarefa" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 05/11/2018
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lixeira: To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Main CSS -->
    <link rel="stylesheet" href="../css/main.css">
</head>
<body>

<% List<Tarefa> tarefas = (List<Tarefa>) request.getAttribute("tarefas"); %>

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
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=listTasks" title="Dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger active" href="/TarefaCtr?action=lixeira" title="Lixeira">Lixeira</a>
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
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-sm-8">
                                <div class="row">
                                    <div class="col-sm-4 mb-1">
                                        <button class="btn btn-danger btn-block" <%=tarefas.size() == 0 ? "disabled" : ""%> type="button" data-toggle="modal" data-target="#excluirTarefa">Excluir Selecionados</button>
                                    </div>
                                    <div class="col-sm-4 mb-1">
                                        <button class="btn btn-secondary btn-block" <%=tarefas.size() == 0 ? "disabled" : ""%> type="button" data-toggle="modal" data-target="#restaurarTarefa">Restaurar Selecionados</button>
                                    </div>
                                    <div class="col-sm-4 mb-1">
                                        <button class="btn btn-secondary btn-block" <%=tarefas.size() == 0 ? "disabled" : ""%> type="button" data-toggle="modal" data-target="#restaurarTarefa" data-rall="true">Restaurar Todos</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2 offset-sm-2 text-right">
                                <button class="btn btn-danger btn-block" <%=tarefas.size() == 0 ? "disabled" : ""%> type="button" data-toggle="modal" data-target="#excluirTarefa" data-dall="true">Esvaziar</button>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col-sm-12">
                                <table class="table table-striped table-borderless">
                                    <thead class="thead-light">
                                    <tr>
                                        <th class="align-middle">
                                            <div class="form-check">
                                                <input class="form-check-input position-static" type="checkbox"
                                                       id="checkall" value="" title="Selecionar Todos">
                                            </div>
                                        </th>
                                        <th>Tarefa</th>
                                        <th>Estado</th>
                                        <th class="text-right">Opções</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    <% if (tarefas.size() == 0) { %>
                                    <tr>
                                        <td colspan="4" class="text-center">Nenhuma Tarefa Encontrada!</td>
                                    </tr>
                                    <% } for (Tarefa tarefa : tarefas) { %>
                                    <tr class="hover-cell">
                                        <td class="align-middle">
                                            <div class="form-check">
                                                <input class="form-check-input position-static" type="checkbox"
                                                       name="check<%=tarefa.getCodigo()%>" id="check<%=tarefa.getCodigo()%>" value="<%=tarefa.getCodigo()%>">
                                            </div>
                                        </td>
                                        <td>
                                            <span data-toggle="modal">
                                                <h5 title="Editar Tarefa"><%=tarefa.getTitulo()%></h5>
                                            </span>
                                            <span class="d-inline-block"><%=tarefa.getTexto()%></span>
                                        </td>
                                        <td class="align-middle">
                                            <%=tarefa.getEstado().getTitulo()%>
                                        </td>
                                        <td class="text-right align-middle">
                                            <a href="#" data-toggle="modal" data-target="#restaurarTarefa" data-codigo="<%=tarefa.getCodigo()%>">&#8634;</a>
                                            <a href="#" data-toggle="modal" data-target="#excluirTarefa" data-codigo="<%=tarefa.getCodigo()%>">&#128465;</a>
                                        </td>
                                    </tr>
                                    <% } %>

                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modal -->
<div class="modal fade" id="excluirTarefa" tabindex="-1" role="dialog">
    <form name="deleteTask" action="/TarefaCtr?action=dropTask" method="post">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Excluir Tarefa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <input type="hidden" name="dcodigo" id="dcodigo">
                    <p>Tem certeza que quer excluir "Permanentemente" esta(s) tarefa(s)?</p>
                </div>
                <div class="modal-footer">
                    <div class="col-6">
                        <button type="submit" class="btn btn-danger">Excluir</button>
                    </div>
                    <div class="col-6 text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- Modal -->
<div class="modal fade" id="restaurarTarefa" tabindex="-1" role="dialog">
    <form name="restoreTask" action="/TarefaCtr?action=restoreTask" method="post">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Restaurar Tarefa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <input type="hidden" name="rcodigo" id="rcodigo">
                    <p>Tem certeza que quer restaurar esta(s) tarefa(s)?</p>
                </div>
                <div class="modal-footer">
                    <div class="col-6">
                        <button type="submit" class="btn btn-success">Restaurar</button>
                    </div>
                    <div class="col-6 text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- Modal -->
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content bg-danger text-white">
            <div class="modal-header">
                <h5 class="modal-title">Erro</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <p>Selecione ao menos uma Tarefa!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-light" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript -->
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

<script !src="">
    var dall = false;
    var rall = false;

    $('#excluirTarefa').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var recipient = button.data(); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        if (recipient.dall == 'true' || recipient.dall == true) {
            dall = true;
        }
        modal.find('.modal-body input[name=dcodigo]').val(recipient.codigo);
    });

    $('#restaurarTarefa').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var recipient = button.data(); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        if (recipient.rall == 'true' || recipient.rall == true) {
            rall = true;
        }
        modal.find('.modal-body input[name=rcodigo]').val(recipient.codigo);
    });

    $("form[name=deleteTask]").on('submit', function (e) {
        e.preventDefault();
        var form = $(this);
        var dcodigos = [];
        var dcodigo = form.find('input[name=dcodigo]').val();
        if (dcodigo === "") {
            //$("input.form-check-input").each(function() {
            $("input.form-check-input[name^='check']").each(function () {
                if (dall) {
                    dcodigos.push(this.value);
                } else {
                    if ($(this).is(':checked'))
                        dcodigos.push(this.value);
                }
            });
            form.find('input[name=dcodigo]').val(dcodigos.toString());
        }
        if (dcodigo === "" && dcodigos.length === 0) {
            $("#excluirTarefa").modal('toggle');
            $("#errorModal").modal('toggle');
            //alert("Nenhuma Tarefa Selecionada!");
        } else {
            this.submit();
        }
    });

    $("form[name=restoreTask]").on('submit', function (e) {
        e.preventDefault();
        var form = $(this);
        var rcodigos = [];
        var rcodigo = form.find('input[name=rcodigo]').val();
        if (rcodigo === "") {
            //$("input.form-check-input").each(function() {
            $("input.form-check-input[name^='check']").each(function () {
                if (rall) {
                    rcodigos.push(this.value);
                } else {
                    if ($(this).is(':checked'))
                        rcodigos.push(this.value);
                }
            });
            form.find('input[name=rcodigo]').val(rcodigos.toString());
        }
        if (rcodigo === "" && rcodigos.length === 0) {
            $("#restaurarTarefa").modal('toggle');
            $("#errorModal").modal('toggle');
            //alert("Nenhuma Tarefa Selecionada!");
        } else {
            this.submit();
        }
    });

    $("input[type=checkbox]").on('click', function () {
        checkChecks();
    });

    $("#checkall").on('click', function (e) {
        var checked = $(this).is(':checked');
        $("input[type=checkbox]").each(function () {
            $(this).attr('checked', checked ? true : false);
        });
        checkChecks();
    });

    function checkChecks() {
        var cchecked = 0;
        ///$("input.form-check-input").each(function() {
        $("input[type=checkbox]").each(function() {
            if ($(this).is(':checked')) ++cchecked;
        });
        $("button[data-dall=true]").attr('disabled', cchecked == 0 ? false : true);
        $("button[data-rall=true]").attr('disabled', cchecked == 0 ? false : true);
    }
</script>

</body>
</html>
