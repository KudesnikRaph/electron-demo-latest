// preload/index.js
import { contextBridge, ipcRenderer } from 'electron'
import { electronAPI } from '@electron-toolkit/preload'

const api = {
  // Цеха
  getWorkshops: () => ipcRenderer.invoke('getWorkshops'),
  createWorkshop: (w) => ipcRenderer.invoke('createWorkshop', w),
  updateWorkshop: (w) => ipcRenderer.invoke('updateWorkshop', w),

  // Типы продукции
  getProductTypes: () => ipcRenderer.invoke('getProductTypes'),
  createProductType: (pt) => ipcRenderer.invoke('createProductType', pt),
  updateProductType: (pt) => ipcRenderer.invoke('updateProductType', pt),

  // Материалы
  getMaterials: () => ipcRenderer.invoke('getMaterials'),
  createMaterial: (m) => ipcRenderer.invoke('createMaterial', m),
  updateMaterial: (m) => ipcRenderer.invoke('updateMaterial', m),

  // Продукция
  getProducts: () => ipcRenderer.invoke('getProducts'),
  createProduct: (p) => ipcRenderer.invoke('createProduct', p),
  updateProduct: (p) => ipcRenderer.invoke('updateProduct', p),

  // Продукция ↔ Цех
  getProductWorkshops: () => ipcRenderer.invoke('getProductWorkshops'),
  createProductWorkshop: (pw) => ipcRenderer.invoke('createProductWorkshop', pw),
  updateProductWorkshop: (pw) => ipcRenderer.invoke('updateProductWorkshop', pw)
}

if (process.contextIsolated) {
  try {
    contextBridge.exposeInMainWorld('electron', electronAPI)
    contextBridge.exposeInMainWorld('api', api)
  } catch (error) {
    console.error(error)
  }
} else {
  window.electron = electronAPI
  window.api = api
}
