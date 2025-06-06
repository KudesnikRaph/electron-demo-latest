// main/index.js
import { app, shell, BrowserWindow, ipcMain, dialog } from 'electron'
import { join } from 'path'
import { electronApp, optimizer, is } from '@electron-toolkit/utils'
import connectDB from './db'  // <-- ваш уже рабочий коннектор

let dbclient = null

// -----------------------------
// 1) Цеха (workshops)
// -----------------------------
async function getWorkshops() {
  try {
    // просто SELECT * из workshops
    const res = await dbclient.query(`
      SELECT id, 
             name, 
             type   AS workshop_type, 
             workers_count 
      FROM workshops
      ORDER BY id
    `)
    return res.rows
  } catch (e) {
    console.error('getWorkshops error:', e)
    return []
  }
}

async function createWorkshop(event, w) {
  const { name, workshop_type, workers_count } = w
  try {
    await dbclient.query(
      `INSERT INTO workshops (name, type, workers_count) VALUES ($1, $2, $3)`,
      [name, workshop_type, workers_count]
    )
    dialog.showMessageBox({ message: 'Успех! Цех создан.' })
    return { success: true }
  } catch (e) {
    console.error('createWorkshop error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось создать цех:\n' + e.message)
    return { success: false, error: e.message }
  }
}

async function updateWorkshop(event, w) {
  const { id, name, workshop_type, workers_count } = w
  try {
    await dbclient.query(
      `UPDATE workshops
         SET name = $1,
             type = $2,
             workers_count = $3
       WHERE id = $4`,
      [name, workshop_type, workers_count, id]
    )
    dialog.showMessageBox({ message: 'Успех! Цех обновлён.' })
    return { success: true }
  } catch (e) {
    console.error('updateWorkshop error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось обновить цех:\n' + e.message)
    return { success: false, error: e.message }
  }
}

// -----------------------------
// 2) Типы продукции (product_types)
// -----------------------------
async function getProductTypes() {
  try {
    const res = await dbclient.query(`
      SELECT id, type_name, coeff_type
      FROM product_types
      ORDER BY id
    `)
    return res.rows
  } catch (e) {
    console.error('getProductTypes error:', e)
    return []
  }
}

async function createProductType(event, pt) {
  const { type_name, coeff_type } = pt
  try {
    await dbclient.query(
      `INSERT INTO product_types (type_name, coeff_type) VALUES ($1, $2)`,
      [type_name, coeff_type]
    )
    dialog.showMessageBox({ message: 'Успех! Тип продукции создан.' })
    return { success: true }
  } catch (e) {
    console.error('createProductType error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось создать тип продукции:\n' + e.message)
    return { success: false, error: e.message }
  }
}

async function updateProductType(event, pt) {
  const { id, type_name, coeff_type } = pt
  try {
    await dbclient.query(
      `UPDATE product_types
         SET type_name = $1,
             coeff_type = $2
       WHERE id = $3`,
      [type_name, coeff_type, id]
    )
    dialog.showMessageBox({ message: 'Успех! Тип продукции обновлён.' })
    return { success: true }
  } catch (e) {
    console.error('updateProductType error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось обновить тип продукции:\n' + e.message)
    return { success: false, error: e.message }
  }
}

// -----------------------------
// 3) Материалы (materials)
// -----------------------------
async function getMaterials() {
  try {
    const res = await dbclient.query(`
      SELECT id, material_name, loss_percentage
      FROM materials
      ORDER BY id
    `)
    return res.rows
  } catch (e) {
    console.error('getMaterials error:', e)
    return []
  }
}

async function createMaterial(event, m) {
  const { material_name, loss_percentage } = m
  try {
    await dbclient.query(
      `INSERT INTO materials (material_name, loss_percentage) VALUES ($1, $2)`,
      [material_name, loss_percentage]
    )
    dialog.showMessageBox({ message: 'Успех! Материал создан.' })
    return { success: true }
  } catch (e) {
    console.error('createMaterial error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось создать материал:\n' + e.message)
    return { success: false, error: e.message }
  }
}

async function updateMaterial(event, m) {
  const { id, material_name, loss_percentage } = m
  try {
    await dbclient.query(
      `UPDATE materials
         SET material_name = $1,
             loss_percentage = $2
       WHERE id = $3`,
      [material_name, loss_percentage, id]
    )
    dialog.showMessageBox({ message: 'Успех! Материал обновлён.' })
    return { success: true }
  } catch (e) {
    console.error('updateMaterial error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось обновить материал:\n' + e.message)
    return { success: false, error: e.message }
  }
}

// -----------------------------
// 4) Продукция (products)
// -----------------------------
async function getProducts() {
  try {
    const res = await dbclient.query(`
      SELECT
        p.id,
        p.product_type_id,
        p.name,
        p.article,
        p.min_cost,
        p.material_id,
        pt.type_name,
        pt.coeff_type,
        m.material_name,
        m.loss_percentage
      FROM products AS p
      LEFT JOIN product_types AS pt ON p.product_type_id = pt.id
      LEFT JOIN materials     AS m  ON p.material_id = m.id
      ORDER BY p.id
    `)
    return res.rows
  } catch (e) {
    console.error('getProducts error:', e)
    return []
  }
}

async function createProduct(event, p) {
  const { product_type_id, name, article, min_cost, material_id } = p
  try {
    await dbclient.query(
      `INSERT INTO products (product_type_id, name, article, min_cost, material_id)
       VALUES ($1, $2, $3, $4, $5)`,
      [product_type_id, name, article, min_cost, material_id]
    )
    dialog.showMessageBox({ message: 'Успех! Продукт создан.' })
    return { success: true }
  } catch (e) {
    console.error('createProduct error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось создать продукт:\n' + e.message)
    return { success: false, error: e.message }
  }
}

async function updateProduct(event, p) {
  const { id, product_type_id, name, article, min_cost, material_id } = p
  try {
    await dbclient.query(
      `UPDATE products
         SET product_type_id = $1,
             name            = $2,
             article         = $3,
             min_cost        = $4,
             material_id     = $5
       WHERE id = $6`,
      [product_type_id, name, article, min_cost, material_id, id]
    )
    dialog.showMessageBox({ message: 'Успех! Продукт обновлён.' })
    return { success: true }
  } catch (e) {
    console.error('updateProduct error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось обновить продукт:\n' + e.message)
    return { success: false, error: e.message }
  }
}

// -----------------------------
// 5) Связь «Продукт ↔ Цех» (product_workshops)
// -----------------------------
async function getProductWorkshops() {
  try {
    const res = await dbclient.query(`
      SELECT
        pw.id,
        pw.product_id,
        pw.workshop_id,
        pw.coefficient,
        p.name AS product_name,
        w.name AS workshop_name
      FROM product_workshops AS pw
      LEFT JOIN products  AS p ON pw.product_id  = p.id
      LEFT JOIN workshops AS w ON pw.workshop_id = w.id
      ORDER BY pw.id
    `)
    return res.rows
  } catch (e) {
    console.error('getProductWorkshops error:', e)
    return []
  }
}

async function createProductWorkshop(event, pw) {
  const { product_id, workshop_id, coefficient } = pw
  try {
    await dbclient.query(
      `INSERT INTO product_workshops (product_id, workshop_id, coefficient)
       VALUES ($1, $2, $3)`,
      [product_id, workshop_id, coefficient]
    )
    dialog.showMessageBox({ message: 'Успех! Связь создана.' })
    return { success: true }
  } catch (e) {
    console.error('createProductWorkshop error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось создать связь:\n' + e.message)
    return { success: false, error: e.message }
  }
}

async function updateProductWorkshop(event, pw) {
  const { id, product_id, workshop_id, coefficient } = pw
  try {
    await dbclient.query(
      `UPDATE product_workshops
         SET product_id  = $1,
             workshop_id = $2,
             coefficient = $3
       WHERE id = $4`,
      [product_id, workshop_id, coefficient, id]
    )
    dialog.showMessageBox({ message: 'Успех! Связь обновлена.' })
    return { success: true }
  } catch (e) {
    console.error('updateProductWorkshop error:', e)
    dialog.showErrorBox('Ошибка', 'Не удалось обновить связь:\n' + e.message)
    return { success: false, error: e.message }
  }
}

// -----------------------------
// Создание окна и регистрация IPC
// -----------------------------
function createWindow() {
  const mainWindow = new BrowserWindow({
    width: 900,
    height: 670,
    show: false,
    icon: join(__dirname, '../../resources/icon.ico'),
    autoHideMenuBar: true,
    webPreferences: {
      preload: join(__dirname, '../preload/index.js'),
      sandbox: false
    }
  })

  mainWindow.on('ready-to-show', () => {
    mainWindow.show()
  })

  mainWindow.webContents.setWindowOpenHandler((details) => {
    shell.openExternal(details.url)
    return { action: 'deny' }
  })

  if (is.dev && process.env['ELECTRON_RENDERER_URL']) {
    mainWindow.loadURL(process.env['ELECTRON_RENDERER_URL'])
  } else {
    mainWindow.loadFile(join(__dirname, '../renderer/index.html'))
  }
}

app.whenReady().then(async () => {
  electronApp.setAppUserModelId('com.electron')

  // Подключаемся к БД
  dbclient = await connectDB()

  // Цеха
  ipcMain.handle('getWorkshops', getWorkshops)
  ipcMain.handle('createWorkshop', createWorkshop)
  ipcMain.handle('updateWorkshop', updateWorkshop)

  // Типы продукции
  ipcMain.handle('getProductTypes', getProductTypes)
  ipcMain.handle('createProductType', createProductType)
  ipcMain.handle('updateProductType', updateProductType)

  // Материалы
  ipcMain.handle('getMaterials', getMaterials)
  ipcMain.handle('createMaterial', createMaterial)
  ipcMain.handle('updateMaterial', updateMaterial)

  // Продукция
  ipcMain.handle('getProducts', getProducts)
  ipcMain.handle('createProduct', createProduct)
  ipcMain.handle('updateProduct', updateProduct)

  // Продукция ↔ Цех
  ipcMain.handle('getProductWorkshops', getProductWorkshops)
  ipcMain.handle('createProductWorkshop', createProductWorkshop)
  ipcMain.handle('updateProductWorkshop', updateProductWorkshop)

  app.on('browser-window-created', (_, window) => {
    optimizer.watchWindowShortcuts(window)
  })

  createWindow()

  app.on('activate', function () {
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})
