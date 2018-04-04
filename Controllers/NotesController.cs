using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using NotesAPI.Models;

namespace NotesAPI.Controllers
{
    public class NotesController : Controller
    {
        private readonly NotesDatabaseContext _context;

        public NotesController(NotesDatabaseContext context)
        {
            _context = context;
        }

        // GET: Notes
        public async Task<IActionResult> Index()
        {
            var notesDatabaseContext = _context.Notes.Include(n => n.Category).Include(n => n.User);
            return View(await notesDatabaseContext.ToListAsync());
        }

        // GET: Notes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var notes = await _context.Notes
                .Include(n => n.Category)
                .Include(n => n.User)
                .SingleOrDefaultAsync(m => m.Id == id);
            if (notes == null)
            {
                return NotFound();
            }

            return View(notes);
        }

        // GET: Notes/Create
        public IActionResult Create()
        {
            ViewData["CategoryId"] = new SelectList(_context.Category, "Id", "Id");
            ViewData["UserId"] = new SelectList(_context.User, "Id", "Email");
            return View();
        }

        // POST: Notes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Title,Note,CreatedOn,CategoryId,IsDeleted,UserId")] Notes notes)
        {
            if (ModelState.IsValid)
            {
                _context.Add(notes);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CategoryId"] = new SelectList(_context.Category, "Id", "Id", notes.CategoryId);
            ViewData["UserId"] = new SelectList(_context.User, "Id", "Email", notes.UserId);
            return View(notes);
        }

        // GET: Notes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var notes = await _context.Notes.SingleOrDefaultAsync(m => m.Id == id);
            if (notes == null)
            {
                return NotFound();
            }
            ViewData["CategoryId"] = new SelectList(_context.Category, "Id", "Id", notes.CategoryId);
            ViewData["UserId"] = new SelectList(_context.User, "Id", "Email", notes.UserId);
            return View(notes);
        }

        // POST: Notes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Title,Note,CreatedOn,CategoryId,IsDeleted,UserId")] Notes notes)
        {
            if (id != notes.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(notes);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!NotesExists(notes.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["CategoryId"] = new SelectList(_context.Category, "Id", "Id", notes.CategoryId);
            ViewData["UserId"] = new SelectList(_context.User, "Id", "Email", notes.UserId);
            return View(notes);
        }

        // GET: Notes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var notes = await _context.Notes
                .Include(n => n.Category)
                .Include(n => n.User)
                .SingleOrDefaultAsync(m => m.Id == id);
            if (notes == null)
            {
                return NotFound();
            }

            return View(notes);
        }

        // POST: Notes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var notes = await _context.Notes.SingleOrDefaultAsync(m => m.Id == id);
            _context.Notes.Remove(notes);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool NotesExists(int id)
        {
            return _context.Notes.Any(e => e.Id == id);
        }
    }
}
