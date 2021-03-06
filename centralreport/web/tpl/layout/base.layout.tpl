<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>{% block title %}CentralReport{% endblock %}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css">

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/style-responsive.css">

    <script type="text/javascript" src="js/jquery.min.js"></script>

    {% block head_javascript %}{% endblock %}

</head>
<body>
    {% block body %}{% endblock %}

    {% block bottom_javascript %}{% endblock %}
</body>
</html>
