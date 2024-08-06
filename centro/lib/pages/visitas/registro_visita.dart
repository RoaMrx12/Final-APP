import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:centro/models/visita.dart';
import 'package:centro/services/api_service.dart';
import 'package:centro/services/db_service.dart';
import 'package:centro/services/location_service.dart';

class RegistroVisita extends StatefulWidget {
  final String codigoCentro;

  RegistroVisita({required this.codigoCentro});

  @override
  _RegistroVisitaState createState() => _RegistroVisitaState();
}

class _RegistroVisitaState extends State<RegistroVisita> {
  final _formKey = GlobalKey<FormState>();
  late String _cedulaDirector;
  late String _motivo;
  File? _fotoEvidencia;
  File? _notaVoz;
  late String _comentario;
  late String _latitud;
  late String _longitud;
  late String _fecha;
  late String _hora;

  final ImagePicker _picker = ImagePicker();
  final Record _record = Record();
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _cedulaDirector = '';
    _motivo = '';
    _comentario = '';
    _latitud = '';
    _longitud = '';
    _fecha = '';
    _hora = '';
    _obtenerUbicacion();
  }

  Future<void> _obtenerUbicacion() async {
    try {
      final ubicacion = await _locationService.getCurrentLocation();
      setState(() {
        _latitud = ubicacion['latitude'].toString();
        _longitud = ubicacion['longitude'].toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error obteniendo ubicación: ${e.toString()}')));
    }
  }

  Future<void> _registrarVisita() async {
    if (_formKey.currentState?.validate() ?? false) {
      final visita = Visita(
        cedulaDirector: _cedulaDirector,
        codigoCentro: widget.codigoCentro,
        motivo: _motivo,
        fotoPath: _fotoEvidencia?.path ?? '',
        comentario: _comentario,
        audioPath: _notaVoz?.path ?? '',
        latitud: _latitud,
        longitud: _longitud,
        fecha: _fecha,
        hora: _hora,
        token: '',
      );

      try {
        // Guardar en la base de datos local
        await DatabaseService().insertVisita(visita);

        // Enviar al servidor remoto
        final mensaje = await ApiService().registrarVisita(visita);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _fotoEvidencia = File(pickedFile.path);
      });
    }
  }

  Future<void> _recordAudio() async {
    if (await _record.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _record.start(path: filePath, encoder: AudioEncoder.AAC);
      setState(() {
        _notaVoz = File(filePath);
      });
    }
  }

  Future<void> _stopRecording() async {
    await _record.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Visita'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cédula del Director'),
                  onChanged: (value) => _cedulaDirector = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la cédula del director';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Motivo'),
                  onChanged: (value) => _motivo = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un motivo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Comentario'),
                  onChanged: (value) => _comentario = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Latitud'),
                  initialValue: _latitud,
                  onChanged: (value) => _latitud = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la latitud';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Longitud'),
                  initialValue: _longitud,
                  onChanged: (value) => _longitud = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la longitud';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
                  onChanged: (value) => _fecha = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Hora (HH:MM)'),
                  onChanged: (value) => _hora = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la hora';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                if (_fotoEvidencia != null)
                  Image.file(_fotoEvidencia!, height: 150),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Tomar Foto de Evidencia'),
                ),
                if (_notaVoz != null)
                  Text('Nota de voz grabada: ${_notaVoz!.path}'),
                ElevatedButton(
                  onPressed: _recordAudio,
                  child: Text('Grabar Nota de Voz'),
                ),
                ElevatedButton(
                  onPressed: _stopRecording,
                  child: Text('Detener Grabación'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registrarVisita,
                  child: Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
