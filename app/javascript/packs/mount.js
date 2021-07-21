import React from 'react'
import ReactDOM from 'react-dom'
import UsersView from './users_view';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<UsersView />, document.getElementById('react_root'))
})
