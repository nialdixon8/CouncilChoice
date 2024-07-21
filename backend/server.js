const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 5000;

app.use(bodyParser.json());
app.use(cors());

let projects = [];
let users = [];
let userSelections = [];

// Endpoints
app.get('/api/projects', (req, res) => {
  res.json(projects);
});

app.post('/api/projects', (req, res) => {
  const project = { id: projects.length + 1, name: req.body.name, cost: parseFloat(req.body.cost), allocated: 0 };
  projects.push(project);
  res.json(project);
});

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  let user = users.find(user => user.username === username);
  if (!user) {
    user = { username, password, id: users.length + 1 };
    users.push(user);
  }
  res.json(user);
});

app.post('/api/user-selections', (req, res) => {
  const { userId, allocations } = req.body;

  // Update project allocations
  for (const [projectId, amount] of Object.entries(allocations)) {
    const project = projects.find(p => p.id === parseInt(projectId));
    if (project) {
      project.allocated += parseFloat(amount);
    }
  }

  userSelections.push({ userId, allocations });
  res.json({ status: 'success' });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
