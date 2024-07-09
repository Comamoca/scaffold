import { defineConfig } from "vite";
import pages from "@hono/vite-cloudflare-pages";
import honox from "honox/vite";

export default defineConfig({
  plugins: [honox(), pages()],
});
