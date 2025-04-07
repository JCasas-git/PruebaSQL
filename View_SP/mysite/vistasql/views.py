from django.shortcuts import render

# Create your views here.
from rest_framework.viewsets import ViewSet
from rest_framework.response import Response
from rest_framework import status
from rest_framework.renderers import TemplateHTMLRenderer
from django.db import connection, DatabaseError

class ConsultarDatosViewSet(ViewSet):
    renderer_classes = [TemplateHTMLRenderer]
    """
    Un ViewSet que ejecuta el procedimiento almacenado sp_Consultar_Datos
    con los parámetros ?UserName=...&Tabla=...
    """

    def list(self, request):
        username = request.query_params.get('UserName')
        tabla = request.query_params.get('Tabla')

        if not username or not tabla:
            return Response({'error': 'Se requieren los parámetros UserName y Tabla'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            with connection.cursor() as cursor:
                print ("Antes SP")
                cursor.execute("EXEC sp_Consultar_Datos @UserName = %s, @Tabla = %s", [username, tabla])
                print ("Despues SP")
                columns = [col[0] for col in cursor.description]
                rows = cursor.fetchall()
                print ("Antes Data")
            data = [dict(zip(columns, row)) for row in rows]
            print (data)
            return Response({'datos': data}, template_name='api.html')
#            return Response(render (request, 'api.html', {'prueba': data}))
#            return Response({'prueba': data})
        except DatabaseError as e:
            # Este tipo de error ocurre por RAISERROR o problemas de permisos
            return Response(
                {'error': str(e)},
                status=status.HTTP_403_FORBIDDEN,
                template_name='api.html'
            )
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)