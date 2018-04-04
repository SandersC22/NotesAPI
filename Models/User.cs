using System;
using System.Collections.Generic;

namespace NotesAPI.Models
{
    public partial class User
    {
        public User()
        {
            Notes = new HashSet<Notes>();
        }

        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public DateTime CreatedOn { get; set; }

        public ICollection<Notes> Notes { get; set; }
    }
}
