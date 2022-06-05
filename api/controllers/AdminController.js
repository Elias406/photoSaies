const path = require("path");
const fs = require("fs");

/**
 * SesionController
 *
 * @description :: Server-side actions for handling incoming requests.
 * @help        :: See https://sailsjs.com/docs/concepts/actions
 */

module.exports = {
  inicioSesion: async (peticion, respuesta) => {
    respuesta.view("pages/admin/inicio_sesion");
  },

  procesarInicioSesion: async (peticion, respuesta) => {
    let admin = await Admin.findOne({
      email: peticion.body.email,
      contrasena: peticion.body.contrasena,
    });
    if (admin) {
      let activo = await Admin.findOne({
        email: peticion.body.email,
        contrasena: peticion.body.contrasena,
        activa: true,
      });
      if (activo) {
        peticion.session.admin = admin;
        peticion.session.cliente = undefined;
        peticion.addFlash("mensaje", "Sesión de admin iniciada");
        return respuesta.redirect("/admin/principal");
      } else {
        peticion.addFlash("mensaje", "Admin desactivado");
        return respuesta.redirect("/admin/inicio-sesion");
      }
    } else {
      peticion.addFlash("mensaje", "Email o contraseña invalidos");
      return respuesta.redirect("/admin/inicio-sesion");
    }
  },

  principal: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash("mensaje", "Sesión inválida");
      return respuesta.redirect("/admin/inicio-sesion");
    }
    let fotos = await Foto.find().sort("id");
    respuesta.view("pages/admin/principal", { fotos });
  },

  cerrarSesion: async (peticion, respuesta) => {
    peticion.session.admin = undefined;
    peticion.addFlash("mensaje", "Sesión finalizada");
    return respuesta.redirect("/");
  },

  agregarFoto: async (peticion, respuesta) => {
    respuesta.view("pages/admin/agregar_foto");
  },

  procesarAgregarFoto: async (peticion, respuesta) => {
    let foto = await Foto.create({
      titulo: peticion.body.titulo,
      activa: true,
    }).fetch();
    peticion.file("foto").upload({}, async (error, archivos) => {
      if (archivos && archivos[0]) {
        let upload_path = archivos[0].fd;
        let ext = path.extname(upload_path);

        await fs
          .createReadStream(upload_path)
          .pipe(
            fs.createWriteStream(
              path.resolve(
                sails.config.appPath,
                `assets/images/fotos/${foto.id}${ext}`
              )
            )
          );
        await Foto.update({ id: foto.id }, { contenido: `${foto.id}${ext}` });
        peticion.addFlash("mensaje", "Foto agregada");
        return respuesta.redirect("/admin/principal");
      }
      peticion.addFlash("mensaje", "No hay foto seleccionada");
      return respuesta.redirect("/admin/agregar-foto");
    });
  },

  desactivarFoto: async (peticion, respuesta) => {
    await Foto.update({ id: peticion.params.fotoId }, { activa: false });
    peticion.addFlash("mensaje", "Foto desactivada");
    return respuesta.redirect("/admin/principal");
  },

  activarFoto: async (peticion, respuesta) => {
    await Foto.update({ id: peticion.params.fotoId }, { activa: true });
    peticion.addFlash("mensaje", "Foto activada");
    return respuesta.redirect("/admin/principal");
  },

  cliente: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash("mensaje", "Sesión inválida");
      return respuesta.redirect("/admin/inicio_sesion");
    } else {
      let cliente = await Cliente.find().sort("id");

      respuesta.view("pages/admin/cliente", { cliente });
    }
  },

  verOrdenes: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      return respuesta.redirect("admin/inicio_sesion");
    } else {
      let consulta = `
    SELECT
      *
    FROM
      orden
      where cliente_id = ${peticion.params.id}
    `;

      await Orden.query(consulta, [], (error, resultado) => {
        let ordenes = resultado.rows;
        respuesta.view("pages/admin/ordenesC", { ordenes });
      });
    }
  },

  verFotos: async (peticion, respuesta) => {
    let consulta = `SELECT foto.contenido, foto.titulo, foto.id FROM foto
                    INNER JOIN orden_detalle ON orden_detalle.foto_id = foto.ID 
                    where orden_detalle.orden_id = ${peticion.params.idOrden}
                    ORDER BY id DESC;`;
    let idCliente = await OrdenDetalle.query(
      consulta,
      [],
      (error, resultado) => {
        let fotos = resultado.rows;
        respuesta.view("pages/admin/fotosDeOrden", { fotos });
      }
    );
  },

  desactivarCliente: async (peticion, respuesta) => {
    await Cliente.update({ id: peticion.params.clienteId }, { activa: false });
    peticion.addFlash("mensaje", "Cliente desactivado");
    return respuesta.redirect("/admin/clientes");
  },

  activarCliente: async (peticion, respuesta) => {
    await Cliente.update({ id: peticion.params.clienteId }, { activa: true });
    peticion.addFlash("mensaje", "Cliente activado");
    return respuesta.redirect("/admin/clientes");
  },

  administradores: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash("mensaje", "Sesión inválida");
      return respuesta.redirect("/admin/inicio_sesion");
    } else {
      let admin = await Admin.find().sort("id");
      let adminSessions = peticion.session.admin;
      respuesta.view("pages/admin/administradores", { admin, adminSessions });
    }
  },

  desactivarAdmin: async (peticion, respuesta) => {
    await Admin.update({ id: peticion.params.idAdmin }, { activa: false });
    peticion.addFlash("mensaje", "Administrador desactivado");
    return respuesta.redirect("/admin/administradores");
  },

  activarAdmin: async (peticion, respuesta) => {
    await Admin.update({ id: peticion.params.idAdmin }, { activa: true });
    peticion.addFlash("mensaje", "Administrador Activado");
    return respuesta.redirect("/admin/administradores");
  },

  dashboard: async (peticion, respuesta) => {
    if (!peticion.session || !peticion.session.admin) {
      peticion.addFlash("mensaje", "Sesión inválida");
      return respuesta.redirect("/admin/inicio_sesion");
    } else {
      let cantidadAdmins = (await Admin.find()).length;
      let cantidadFotos = (await Foto.find()).length;
      let cantidadClientes = (await Cliente.find()).length;
      let cantidadOrdenes = (await Orden.find()).length;

      respuesta.view("pages/admin/dashboard", {
        cantidadClientes,
        cantidadFotos,
        cantidadAdmins,
        cantidadOrdenes,
      });
    }
  },
};
