using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace NotesAPI.Models
{
    public partial class NotesDatabaseContext : DbContext
    {
        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<Notes> Notes { get; set; }
        public virtual DbSet<User> User { get; set; }

        public NotesDatabaseContext(DbContextOptions<NotesDatabaseContext> options) : base(options)
        { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category", "Entities");

                entity.Property(e => e.Name).HasMaxLength(50);
            });

            modelBuilder.Entity<Notes>(entity =>
            {
                entity.ToTable("Notes", "Entities");

                entity.Property(e => e.CreatedOn).HasColumnType("datetime");

                entity.Property(e => e.Note)
                    .IsRequired()
                    .HasMaxLength(150);

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Notes)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Notes__CategoryI__5070F446");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Notes)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Notes__UserId__4F7CD00D");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User", "Entities");

                entity.Property(e => e.CreatedOn).HasColumnType("datetime");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);
            });
        }
    }
}
