// renderer/src/CreateWorkshop.jsx
import { useEffect } from 'react'
import { Link } from 'react-router-dom'

export default function CreateWorkshop() {
  useEffect(() => {
    document.title = 'Создать цех'
  }, [])

  async function submitHandler(e) {
    e.preventDefault()
    const w = {
      name: e.target.name.value,
      workshop_type: e.target.type.value,
      workers_count: Number(e.target.workers_count.value)
    }
    await window.api.createWorkshop(w)
    document.querySelector('form').reset()
  }

  return (
    <div className="form">
      <Link to={'/'}>
        <button>{"<-- Назад"}</button>
      </Link>

      <h1>Создать цех</h1>
      <form onSubmit={(e) => submitHandler(e)}>
        <label htmlFor="name">Название цеха:</label>
        <input id="name" type="text" required />

        <label htmlFor="type">Тип цеха:</label>
        <select id="type" required>
          <option value="Проектирование">Проектирование</option>
          <option value="Обработка">Обработка</option>
          <option value="Сушка">Сушка</option>
          <option value="Сборка">Сборка</option>
        </select>

        <label htmlFor="workers_count">Количество человек:</label>
        <input id="workers_count" type="number" min="1" step="1" required />

        <button type="submit">Создать цех</button>
      </form>
    </div>
  )
}
