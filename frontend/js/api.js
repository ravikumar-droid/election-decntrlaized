const API_URL = "YOUR_CLOUDFLARE_WORKER_URL_HERE"; // Replace after deploying backend

function checkAuth() {
    const token = localStorage.getItem("token");
    if (!token) window.location.href = "index.html";
    return JSON.parse(atob(token));
}

function logout() {
    localStorage.clear();
    window.location.href = "index.html";
}
