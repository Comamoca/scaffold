import { serve } from "https://deno.land/std/http/server.ts";
import { Hono } from "https://deno.land/x/hono@v4.2.7/mod.ts";

const app = new Hono();

app.get("/", (ctx) => ctx.text("Hello!"));

Deno.serve(app.fetch);
