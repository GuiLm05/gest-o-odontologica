<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OdontoSystem</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { 
            background-color: #f4f6f9; /* Fundo cinza bem clarinho */
        }
        /* Efeito ao passar o mouse nos cards */
        .card-hover {
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
            cursor: pointer;
        }
        .icon-box {
            font-size: 3rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>